import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hands_on_image_picker/friend.dart';
import 'package:hands_on_image_picker/pages/favors_page.dart';
import 'package:hands_on_image_picker/verification_code_input_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  List<Friend> friends;

  LoginPage({Key key, this.friends}) : super(key: key);

  @override
  LoginPageState createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String _phoneNumber = "";
  String _smsCode = "";
  String _verificationId = "";
  int _currentStep = 0;
  List<StepState> _stepsState = [
    StepState.editing,
    StepState.indexed,
    StepState.indexed
  ];
  bool _showProgress = false;
  String _displayName = '';
  File _imageFile;

  bool _labeling = false;
  List<Label> _labels = List();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FavorsPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .display3
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Stepper(
              type: StepperType.vertical,
              steps: <Step>[
                Step(
                  state: _stepsState[0],
                  isActive: _enteringPhoneNumber(),
                  title: Text("Enter your Phone Number"),
                  content: TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9+]")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),
                ),
                Step(
                  state: _stepsState[1],
                  isActive: _enteringVerificationCode(),
                  title: Text("Verification code"),
                  content: VerificationCodeInput(
                    onChanged: (value) {
                      setState(() {
                        _smsCode = value;
                      });
                    },
                  ),
                ),
                Step(
                  state: _stepsState[2],
                  isActive: _editingProfile(),
                  title: Text("Profile"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: CircleAvatar(
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile)
                              : AssetImage('assets/default_avatar.png'),
                        ),
                        onTap: () {
                          _importImage();
                        },
                      ),
                      Container(
                        height: 16,
                      ),                      
                      Text(
                        _labeling
                            ? "Labeling the captured image ..."
                            : "Capture a image to start labeling",
                      ),
                      Container(
                        height: 32.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: min(_labels.length, 5),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) => Text(
                            "${_labels[index].label}, confidence: ${_labels[index].confidence}"),
                      ),
                      Container(
                        height: 16,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Display name"),
                        onChanged: (value) {
                          setState(() {
                            _displayName = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              currentStep: _currentStep,
              controlsBuilder: _stepControlsBuilder,
              onStepContinue: () {
                if (_currentStep == 0) {
                  _sendVerificationCode();
                } else if (_currentStep == 1) {
                  _executeLogin();
                } else {
                  _saveProfile();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepControlsBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    if (_showProgress) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[CircularProgressIndicator()],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          onPressed: onStepContinue,
          child: Text("CONTINUE"),
        ),
      ],
    );
  }

  bool _enteringPhoneNumber() =>
      _currentStep == 0 && _stepsState[0] == StepState.editing;

  _enteringVerificationCode() =>
      _currentStep == 1 && _stepsState[1] == StepState.editing;

  _editingProfile() => _currentStep == 2 && _stepsState[2] == StepState.editing;

  void _sendVerificationCode() async {
    final PhoneCodeSent codeSent = (String verId, [int forceCodeResend]) {
      _verificationId = verId;
      _goToVerificationStep();
    };

    final PhoneVerificationCompleted verificationSuccess = (FirebaseUser user) {
      _loggedIn();
    };

    final PhoneVerificationFailed verificationFail = (AuthException exception) {
      goBackToFirstStep();
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this._verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      codeSent: codeSent,
      verificationCompleted: verificationSuccess,
      verificationFailed: verificationFail,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
      timeout: Duration(seconds: 0),
    );
  }

  void _executeLogin() async {
    setState(() {
      _showProgress = true;
    });

    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    ));

    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        goToProfileStep();
      }
    });
  }

  void _loggedIn() {
    setState(() {
      _showProgress = false;
      _stepsState[1] = StepState.complete;
    });
  }

  void goBackToFirstStep() {
    setState(() {
      _showProgress = false;
      _stepsState[0] = StepState.editing;
      _stepsState[1] = StepState.indexed;
      _currentStep = 0;
    });
  }

  void _goToVerificationStep() {
    setState(() {
      _stepsState[0] = StepState.complete;
      _stepsState[1] = StepState.editing;
      _currentStep = 1;
    });
  }

  void _saveProfile() async {
    setState(() {
      _showProgress = true;
    });

    final user = await FirebaseAuth.instance.currentUser();

    final updateInfo = UserUpdateInfo();
    updateInfo.displayName = _displayName;

    if (_imageFile != null) {
      updateInfo.photoUrl = await uploadPicture(user.uid);
    }

    await user.updateProfile(updateInfo);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FavorsPage(),
      ),
    );
  }

  void goToProfileStep() {
    setState(() {
      _showProgress = false;
      _stepsState[1] = StepState.complete;
      _stepsState[2] = StepState.editing;
      _currentStep = 2;
    });
  }

  void _importImage() async {
    _checkPermissions();
    
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
    _labelImage();
  }

void _checkPermissions() async {
 PermissionStatus status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera); 
    if (status != PermissionStatus.granted) { 
await PermissionHandler().requestPermissions([PermissionGroup.camera]); 
    }
  }

  uploadPicture(String userUid) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('profiles')
        .child('profile_$userUid');

    StorageUploadTask uploadTask =
        ref.putFile(_imageFile, StorageMetadata(contentType: 'image/png'));

    StorageTaskSnapshot lastSnapshot = await uploadTask.onComplete;

    return await lastSnapshot.ref.getDownloadURL();
  }

  _labelImage() async {
    if (_imageFile == null) return;

    setState(() {
      _labeling = true;
    });

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(_imageFile);

    final LabelDetector labelDetector = FirebaseVision.instance.labelDetector();

    List<Label> labels = await labelDetector.detectInImage(visionImage);

    setState(() {
      _labels = labels;
      _labeling = false;
    });
  }
}

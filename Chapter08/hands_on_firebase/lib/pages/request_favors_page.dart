import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hands_on_firebase/favor.dart';
import 'package:hands_on_firebase/friend.dart';
import 'package:intl/intl.dart';

class RequestFavorPage extends StatefulWidget {
  final List<Friend> friends;

  RequestFavorPage({Key key, this.friends}) : super(key: key);

  @override
  RequestFavorPageState createState() {
    return new RequestFavorPageState();
  }
}

class RequestFavorPageState extends State<RequestFavorPage> {
  final _formKey = GlobalKey<FormState>();
  Friend _selectedFriend;
  DateTime _dueDate;
  String _description;
  List<Friend> friends;

  InterstitialAd _interstitialAd;
  BannerAd _bannerAd;

  // sample targeting from https://github.com/flutter/plugins/blob/master/packages/firebase_admob/example/lib/main.dart
  //
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? <String>[testDevice] : null,
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   childDirected: true,
  //   nonPersonalizedAds: true,
  // );

  static RequestFavorPageState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<RequestFavorPageState>());
  }

  @override
  void initState() {
    super.initState();

    Friend newFriend = Friend(name: "New number", uuid: 'new');

    friends = widget.friends..add(newFriend);

    _bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
    )
      ..load()
      ..show();

    _interstitialAd = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
    )..load();
  }

  @override
  void dispose() {
    super.dispose();

    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "request_favor",
      child: Scaffold(
        appBar: AppBar(
          title: Text("Requesting a favor"),
          leading: CloseButton(),
          actions: <Widget>[
            Builder(
              builder: (context) => FlatButton(
                    colorBrightness: Brightness.dark,
                    child: Text("SAVE"),
                    onPressed: () {
                      RequestFavorPageState.of(context).save(context);
                      // we could call save() method directly
                      // as we are in the same class.
                      // intentionally left for exemplification.
                    },
                  ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButtonFormField<Friend>(
                    value: _selectedFriend,
                    onChanged: (friend) {
                      setState(() {
                        _selectedFriend = friend;
                      });
                    },
                    items: friends
                        .map(
                          (f) => DropdownMenuItem<Friend>(
                                value: f,
                                child: Text(f.name),
                              ),
                        )
                        .toList(),
                    validator: (friend) {
                      if (friend == null) {
                        return "You must select a friend to ask the favor";
                      }
                      return null;
                    },
                  ),
                  _selectedFriend?.uuid == 'new'
                      ? TextFormField(
                          maxLines: 1,
                          decoration:
                              InputDecoration(hintText: "Friend phone number"),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "add the new friend phone number";
                            }
                            return null;
                          },
                          onSaved: (number) {
                            _selectedFriend = Friend(number: number);
                          },
                        )
                      : Container(
                          height: 0,
                        ),
                  Container(
                    height: 16.0,
                  ),
                  Text("Favor description:"),
                  TextFormField(
                    maxLines: 5,
                    inputFormatters: [LengthLimitingTextInputFormatter(200)],
                    validator: (value) {
                      if (value.isEmpty) {
                        return "You must detail the favor";
                      }
                      return null;
                    },
                    onSaved: (description) {
                      _description = description;
                    },
                  ),
                  Container(
                    height: 16.0,
                  ),
                  Text("Due Date:"),
                  DateTimePickerFormField(
                    inputType: InputType.both,
                    format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
                    editable: false,
                    decoration: InputDecoration(
                        labelText: 'Date/Time', hasFloatingPlaceholder: false),
                    validator: (dateTime) {
                      if (dateTime == null) {
                        return "You must select a due date time for the favor";
                      }
                      return null;
                    },
                    onSaved: (dateTime) {
                      _dueDate = dateTime;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void save(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final currentUser = await FirebaseAuth.instance.currentUser();

      await _saveFavorOnFirebase(
        Favor(
          to: _selectedFriend.number,
          description: _description,
          dueDate: _dueDate,
          friend: Friend(
            name: currentUser.displayName,
            number: currentUser.phoneNumber,
            photoURL: currentUser.photoUrl,
          ),
        ),
      );

      await _interstitialAd.show();

      Navigator.pop(context);
    }
  }

  _saveFavorOnFirebase(Favor favor) async {
    await Firestore.instance
        .collection('favors')
        .document()
        .setData(favor.toJson());
  }
}

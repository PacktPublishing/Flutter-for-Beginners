import 'package:flutter/material.dart';
import 'package:input/verification_code_input_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: InputControllerExamplesWidget(),
      // home: InputFormFieldExamplesWidget(),
      // home: InputFormExamplesWidget(),
      // home: InputFormInheritedStateExamplesWidget(),
      home: CustomInputStateExamplesWidget(),
    );
  }
}

/// Accessing field state by using a controller
class InputControllerExamplesWidget extends StatelessWidget {
  final _controller = TextEditingController.fromValue(
    TextEditingValue(text: "Initial value"),
  );

  @override
  Widget build(BuildContext context) {
    _controller.addListener(_textFieldEvent);
    return Scaffold(
      body: Center(
        child: TextField(
          controller: _controller,
        ),
      ),
    );
  }

  void _textFieldEvent() {
    print(_controller.text);
  }
}

/// Accessing field state by using a key
class InputFormFieldExamplesWidget extends StatelessWidget {
  final _key = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          print("Current value ${_key.currentState.value}");
        },
        child: Container(
          color: Colors.grey,
          child: Center(
            child: TextFormField(
              key: _key,
            ),
          ),
        ),
      ),
    );
  }
}

/// Click some part of the screen to see the error
class InputFormExamplesWidget extends StatelessWidget {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          final valid = _key.currentState.validate();
          print("Running validation, valid: $valid");
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.grey,
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  validator: (String value) {
                    return value.isEmpty ? "cannot be empty" : null;
                  },
                ),
                TextFormField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Accessing form by InheritedWidget, click some part of body
class InputFormInheritedStateExamplesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                validator: (String value) {
                  return value.isEmpty ? "cannot be empty" : null;
                },
              ),
              Builder(
                builder: (BuildContext context) => RaisedButton(
                      onPressed: () {
                        print("Running validation");
                        final valid = Form.of(context).validate();
                        print("valid: $valid");
                      },
                      child: Text("validate"),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Using the custom VerificationCodeInput in a Form
class CustomInputStateExamplesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                VerificationCodeFormField(
                  validator: (String value) {
                    if (value.isEmpty) return "cannot be empty";
                    if (value.length < 6) return "You must inform all 6 digits";

                    return null;
                  },
                ),
                Builder(
                  builder: (BuildContext context) => RaisedButton(
                        onPressed: () {
                          print("Running validation");
                          final valid = Form.of(context).validate();
                          print("valid: $valid");
                        },
                        child: Text("validate"),
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

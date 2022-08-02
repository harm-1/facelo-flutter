import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _emailController =
      TextEditingController(text: 'abc@abc.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '1234');

  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _submitForm() async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    final _user = <String, String>{
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    print(_user.toString());

    var response = await post(
      Uri.http('172.18.0.3:5000', '/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_user),
    ).timeout(const Duration(seconds: 3));

    print(response);
    // print(response.statusCode);
    // print(jsonDecode(response.body));

    _globalKey.currentState?.showSnackBar(const SnackBar(
      content: Text('Login form submitted'),
    ));

    _formKey.currentState?.save();
    // _formKey.currentState?.reset();
    // _nextFocus(_emailFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test1'),
      ),
      // drawer: const FaceloDrawer(),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                controller: _emailController,
                onFieldSubmitted: (String value) {
                  _nextFocus(_passwordFocusNode);
                },
                decoration: const InputDecoration(
                  label: Text("email address"),
                  hintText: 'enter email address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter email address";
                  } else if (EmailValidator.validate(value) == false) {
                    return 'incorrect email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocusNode,
                controller: _passwordController,
                obscureText: true,
                onFieldSubmitted: (String value) {
                  _submitForm();
                },
                decoration: const InputDecoration(
                  label: Text("password"),
                  hintText: 'enter password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter password";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text('submit'))
            ],
          )),
    );
  }
}

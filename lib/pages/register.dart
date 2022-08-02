import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:select_form_field/select_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordCheckFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();
  final FocusNode _preferenceFocusNode = FocusNode();
  final FocusNode _birthdayFocusNode = FocusNode();

  final TextEditingController _emailController =
      TextEditingController(text: 'abc@abc.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '1234');
  final TextEditingController _passwordCheckController =
      TextEditingController(text: '1234');
  final TextEditingController _genderController =
      TextEditingController(text: 'Male');
  final TextEditingController _preferenceController =
      TextEditingController(text: 'Female');
  final TextEditingController _birthdayController =
      TextEditingController(text: '2000-01-01');

  final List<Map<String, dynamic>> _genderItems = [
    {
      'value': 0,
      'label': 'Please select an option',
      'icon': const Icon(Icons.circle),
    },
    {
      'value': 1,
      'label': 'Male',
      'icon': const Icon(Icons.male),
    },
    {
      'value': 2,
      'label': 'Female',
      'icon': const Icon(Icons.female),
    },
    {
      'value': 3,
      'label': 'Other',
      'icon': const Icon(Icons.transgender),
    },
  ];

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
      'gender': _genderController.text,
      'sexual_preference': _preferenceController.text,
      'birth_day': _birthdayController.text,
      'terms_accepted': 'True',
    };
    // print(_user.toString());

    var response = await post(
      Uri.http('172.18.0.3:5000', '/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_user),
    );
    // var response = await post(
    //   Uri.http('172.18.0.3:5000', '/user'));

    print(response);
    // print(response.statusCode);
    // print(jsonDecode(response.body));

    _globalKey.currentState?.showSnackBar(const SnackBar(
      content: Text('Registration form submitted'),
    ));

    _formKey.currentState?.save();
    // _formKey.currentState?.reset();
    // _nextFocus(_emailFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
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
                  _nextFocus(_passwordCheckFocusNode);
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
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                focusNode: _passwordCheckFocusNode,
                controller: _passwordCheckController,
                obscureText: true,
                onFieldSubmitted: (String value) {
                  _nextFocus(_genderFocusNode);
                },
                decoration: const InputDecoration(
                  label: Text("repeat password"),
                  hintText: 'repeat password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter password check";
                  } else if (value != _passwordController.text) {
                    return 'This is not the same...';
                  }
                  return null;
                },
              ),
              SelectFormField(
                type: SelectFormFieldType.dropdown,
                textInputAction: TextInputAction.next,
                focusNode: _genderFocusNode,
                controller: _genderController,
                labelText: 'Gender',
                items: _genderItems,
                onFieldSubmitted: (String value) {
                  _nextFocus(_preferenceFocusNode);
                },
              ),
              SelectFormField(
                type: SelectFormFieldType.dropdown,
                textInputAction: TextInputAction.next,
                focusNode: _preferenceFocusNode,
                controller: _preferenceController,
                labelText: 'Preference',
                items: _genderItems,
                onFieldSubmitted: (String value) {
                  _nextFocus(_birthdayFocusNode);
                },
              ),
              // InputDatePickerFormField(
              //   lastDate: DateTime.now(),
              //   firstDate: DateTime.utc(1900, 1, 1),
              // ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                focusNode: _birthdayFocusNode,
                controller: _birthdayController,
                decoration: const InputDecoration(
                  label: Text("Enter birthday"),
                  hintText: 'yyyy-mm-dd',
                ),
                onFieldSubmitted: (String value) {
                  _submitForm;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter birthday";
                  }

                  try {
                    DateTime.parse(value);
                  } on FormatException {
                    return "invalid date";
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

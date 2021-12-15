import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenv2_app/pickers/user_image_picker.dart';
import 'package:gravenv2_app/theme/colors.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitAuthForm, this.isLoading);
  final bool isLoading;

  final void Function(
    String email,
    String username,
    String password,
    bool isLoggedIn,
    BuildContext ctx,
    File? image,
  ) submitAuthForm;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLoggedIn = false;

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    //if valid and image exists
    if (isValid) {
      _formKey.currentState!.save();

      //auth request with currentState
      widget.submitAuthForm(_userEmail.trim(), _userName.trim(),
          _userPassword.trim(), _isLoggedIn, context, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                //only takes as much space as needed
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      child: Image.asset('assets/images/graven_logo-temp.png'),
                      height: 175,
                      width: 250),
                  if (!_isLoggedIn) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Theme.of(context).backgroundColor,
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  if (!_isLoggedIn)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Please enter at least 5 characters';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                        fillColor: Theme.of(context).backgroundColor,
                      ),
                      onSaved: (value) {
                        _userName = value.toString();
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be at least 7 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      fillColor: CustomColors.primaryVariant,
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value.toString();
                    },
                  ),
                  const SizedBox(height: 12),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomColors.primaryVariant,
                        fixedSize: const Size(150, 50),
                      ),
                      child: Text(_isLoggedIn ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(
                        _isLoggedIn ? 'Register' : 'I already have an account',
                        style: const TextStyle(
                          color: CustomColors.primary,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLoggedIn = !_isLoggedIn;
                        });
                      },
                    )
                ],
              ),
            ),
          ))),
    );
  }
}

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
  var _isLoggedIn = true;

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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Image.asset('assets/images/Graven_logo-2.png'),
          ),
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                //only takes as much space as needed
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (!_isLoggedIn) UserImagePicker(_pickedImage),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      fillColor: CustomColors.secondary,
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  if (!_isLoggedIn)
                    TextFormField(
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Please enter at least 5 characters';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Användarnamn',
                         fillColor: CustomColors.secondary,
                      ),
                      onSaved: (value) {
                        _userName = value.toString();
                      },
                    ),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be at least 7 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Lösenord',
                      fillColor: CustomColors.secondary,
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
                        fixedSize: const Size(250, 50),
                      ),
                      child: Text(_isLoggedIn ? 'Logga in' : 'Registrera', style: const TextStyle(fontSize: 24)),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: CustomColors.primaryVariant,
                        fixedSize: const Size(250, 50),
                      ),
                      child: Text(
                        _isLoggedIn ? 'Registrera' : 'Jag har redan ett konto',
                        style: const TextStyle(
                          color: CustomColors.secondary,
                          fontSize: 20,
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
          )),
        ],
      ),
    );
  }
}

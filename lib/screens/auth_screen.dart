import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gravenv2_app/forms/auth_form.dart';
import 'package:gravenv2_app/theme/colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    bool isLoggedIn,
    BuildContext ctx,
    File? image,
  ) async {
    UserCredential _authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLoggedIn) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //upload picture to "main bucket" in "user_images"
        //storage reference
        final ref = FirebaseStorage.instance
            .ref()
            .child(
              'user_image',
            )
            .child(
              _authResult.user!.uid + '.jpg',
            );

        //actual file with user uid as path name
        await ref.putFile(image!);

        final url = await ref.getDownloadURL();

        FirebaseFirestore.instance
            .collection('users')
            .doc(_authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          //URL pointer to image
          'image_url': url,
        });

        setState(() {
          _isLoading = false;
        });
      }
      //specify Firebase errors with on keyword
    } on PlatformException catch (error) {
      var message = 'Error occurred, bucko. Clean your room!';

      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.split(" ").toString()),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(err.toString().substring(31)),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [CustomColors.primary, CustomColors.secondary],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )),
            child: AuthForm(
              _submitAuthForm,
              _isLoading,
            )));
  }
}

import 'dart:developer';

import 'package:chatting_app/constants.dart';
import 'package:chatting_app/helper/snack_bar.dart';
import 'package:chatting_app/views/chat_view.dart';
import 'package:chatting_app/views/register_view.dart';
import 'package:chatting_app/widgets/custom_text_button.dart';
import 'package:chatting_app/widgets/custom_text_form_field.dart';
import 'package:chatting_app/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = '';

  String password = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        opacity: 0.6,
        color: kPrimaryColor,
        progressIndicator: const Center(
          child: Card(
            elevation: 10,
            color: Color(0xff1b2e3f),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(
                color: kSecondryColor,
                strokeWidth: 4,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: kViewPadding,
          child: ListView(
            children: [
            const SizedBox(
              height: 150,
            ),
            Image.asset(
              height: 150,
              'assets/images/logo.png',
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chat App',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              labelText: 'Email',
              onChanged: (data) {
                email = data;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              obscureText: true,
              labelText: 'Password',
              onChanged: (data) {
                password = data;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MainButton(
              text: 'Login',
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  await signIn();
                  Navigator.pushNamedAndRemoveUntil(
                      context, ChatView.id, (Route<dynamic> route) => false,
                      arguments: email);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showSnackBar(context, 'No user found for that email');
                  } else if (e.code == 'wrong-password') {
                    showSnackBar(
                        context, 'Wrong password provided for that user');
                  } else {
                    showSnackBar(context, e.message!);
                  }
                } catch (e) {
                  log(e.toString());
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an acount?",
                  style: TextStyle(color: Colors.white),
                ),
                CustomTextButton(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterView.id);
                  },
                  text: 'Register now',
                )
              ],
            )
          ],
        ),
      ),
    ),);
  }

  Future<void> signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}

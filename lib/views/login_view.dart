import 'dart:developer';

import 'package:chatting_app/constants.dart';
import 'package:chatting_app/helper/snack_bar.dart';
import 'package:chatting_app/views/register_view.dart';
import 'package:chatting_app/views/users_view.dart';
import 'package:chatting_app/widgets/custom_text_button.dart';
import 'package:chatting_app/widgets/custom_text_form_field.dart';
import 'package:chatting_app/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: kViewPadding,
          child: ListView(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Icon(
                Icons.forum_rounded,
                size: 64,
                color: kSecondryColor,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Sign in to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextFormField(
                prefixIcon: Icons.email_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (data) {
                  if (data == null || data.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!data.endsWith('.com')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                labelText: 'Email',
                onChanged: (data) {
                  email = data;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                prefixIcon: Icons.lock_rounded,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (data) {
                  if (data == null || data.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  if (data.length < 8) {
                    return 'Password should be 8 characters or more';
                  }
                  return null;
                },
                onFieldSubmitted: (data) {
                  loginUser();
                },
                labelText: 'Password',
                onChanged: (data) {
                  password = data;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : MainButton(
                      text: 'Login',
                      onPressed: () {
                        loginUser();
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
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
      ),
    );
  }

  Future<void> signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> loginUser() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await signIn();
        Navigator.pushNamedAndRemoveUntil(
            context, UsersView.id, (Route<dynamic> route) => false,
            arguments: email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, 'No user found for that email');
        } else if (e.code == 'wrong-password') {
          showSnackBar(context, 'Wrong password provided for that user');
        } else {
          showSnackBar(context, e.message ?? 'An error occurred');
        }
      } catch (e) {
        log(e.toString());
        showSnackBar(context, 'An unexpected error occurred.');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}

import 'dart:developer';
import 'package:chatting_app/constants.dart';
import 'package:chatting_app/helper/snack_bar.dart';
import 'package:chatting_app/views/users_view.dart';
import 'package:chatting_app/widgets/custom_text_button.dart';
import 'package:chatting_app/widgets/custom_text_form_field.dart';
import 'package:chatting_app/widgets/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String username = '';

  String email = '';

  String password = '';

  bool isLoading = false;

  GlobalKey<FormState>? formKey = GlobalKey();

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
                'Create Account',
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
                'Sign up to get started',
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
                prefixIcon: Icons.person_rounded,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (data) {
                  if (data == null || data.trim().isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                labelText: 'Username',
                onChanged: (data) {
                  username = data;
                },
              ),
              const SizedBox(
                height: 16,
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
                  log(data);
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
                  registerUser();
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
                      text: 'Register',
                      onPressed: () {
                        registerUser();
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  CustomTextButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: 'Login now',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'username': username,
      'email': email,
    });
  }

  Future<void> registerUser() async {
    if (formKey!.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await register();
        Navigator.pushNamedAndRemoveUntil(
            context, UsersView.id, (Route<dynamic> route) => false,
            arguments: email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackBar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account already exists for that email.');
        } else {
          showSnackBar(context, e.message ?? e.code);
        }
      } catch (e) {
        showSnackBar(context, 'An unexpected error occurred.');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}

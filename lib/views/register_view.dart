import 'dart:developer';
import 'package:chatting_app/constants.dart';
import 'package:chatting_app/helper/snack_bar.dart';
import 'package:chatting_app/views/chat_view.dart';
import 'package:chatting_app/widgets/custom_text_button.dart';
import 'package:chatting_app/widgets/custom_text_form_field.dart';
import 'package:chatting_app/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
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
                  'Register',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  validator: (data) {
                    if (!data!.endsWith('.com')) {
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
                  height: 10,
                ),
                CustomTextFormField(
                    validator: (data) {
                      if (data!.length < 8) {
                        return 'Password shoud be 8 character or more';
                      }
                      return null;
                    },
                    obscureText: true,
                    labelText: 'Password',
                    onChanged: (data) {
                      password = data;
                    }),
                const SizedBox(
                  height: 10,
                ),
                MainButton(
                  text: 'Register',
                  onPressed: () async {
                    if (formKey!.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        await register();
                        Navigator.pushNamedAndRemoveUntil(context, ChatView.id,
                            (Route<dynamic> route) => false,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        } else {
                          showSnackBar(context, e.code);
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an acount?",
                      style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  Future<void> register() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

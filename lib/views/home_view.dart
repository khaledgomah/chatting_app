import 'package:chatting_app/constants.dart';
import 'package:chatting_app/views/login_view.dart';
import 'package:chatting_app/views/register_view.dart';
import 'package:chatting_app/widgets/main_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'home view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: kViewPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.forum_rounded,
              size: 64,
              color: kSecondryColor,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Chat App',
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
              'Connect instantly with friends',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 48,
            ),
            MainButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, LoginView.id);
                }),
            const SizedBox(
              height: 12,
            ),
            MainButton(
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegisterView.id);
                })
          ],
        ),
      ),
    );
  }
}

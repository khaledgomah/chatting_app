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
            const Text(
              'WELCOME TO CHAT APP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Image.asset(kLogo),
            MainButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, LoginView.id);
                }),
            const SizedBox(
              height: 10,
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

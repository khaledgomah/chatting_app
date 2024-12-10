import 'package:chatting_app/constants.dart';
import 'package:chatting_app/views/login_view.dart';
import 'package:chatting_app/views/register_view.dart';
import 'package:chatting_app/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            Text(
              'WELCOME TO CHAT APP',
              style: GoogleFonts.oswald(
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

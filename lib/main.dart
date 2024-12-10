import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/views/chat_view.dart';
import 'package:chatting_app/views/home_view.dart';
import 'package:chatting_app/views/login_view.dart';
import 'package:chatting_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        HomeView.id: (context) => const HomeView(),
        ChatView.id: (context) => const ChatView()
      },
      initialRoute: HomeView.id,
    );
  }
}

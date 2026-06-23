import 'package:chatting_app/constants.dart';
import 'package:chatting_app/views/chat_view.dart';
import 'package:chatting_app/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersView extends StatelessWidget {
  static String id = 'UsersView';

  const UsersView({super.key});

  String _getChatId(String email1, String email2) {
    return email1.compareTo(email2) < 0 ? '${email1}_$email2' : '${email2}_$email1';
  }

  @override
  Widget build(BuildContext context) {
    final String myEmail = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kCardColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        title: const Text(
          'Conversations',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white70),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeView.id, (route) => false);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: kSecondryColor),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No users found',
                style: TextStyle(color: Colors.white60, fontSize: 16),
              ),
            );
          }

          // Filter out the current user
          final usersList = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['email'] != myEmail;
          }).toList();

          if (usersList.isEmpty) {
            return const Center(
              child: Text(
                'No other users registered yet',
                style: TextStyle(color: Colors.white60, fontSize: 16),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: usersList.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.05),
              height: 1,
              indent: 72,
            ),
            itemBuilder: (context, index) {
              final data = usersList[index].data() as Map<String, dynamic>;
              final String username = data['username'] ?? 'User';
              final String email = data['email'] ?? '';

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: kSecondryColor.withValues(alpha: 0.15),
                  child: Text(
                    username.isNotEmpty ? username.substring(0, 1).toUpperCase() : 'U',
                    style: const TextStyle(
                      color: kSecondryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white24,
                  size: 16,
                ),
                onTap: () {
                  final String chatId = _getChatId(myEmail, email);
                  Navigator.pushNamed(
                    context,
                    ChatView.id,
                    arguments: {
                      'myEmail': myEmail,
                      'theirEmail': email,
                      'theirUsername': username,
                      'chatId': chatId,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

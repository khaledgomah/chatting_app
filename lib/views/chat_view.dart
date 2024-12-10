import 'package:chatting_app/constants.dart';
import 'package:chatting_app/models/message.dart';
import 'package:chatting_app/widgets/recieve_chat_bubble.dart';
import 'package:chatting_app/widgets/send_chat_bubble.dart';
import 'package:chatting_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  static String id = 'chat view';

  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollectionName);
  late Message message;
  late String email;
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Padding(
        padding: kViewPadding,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: messages.orderBy('time', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Message message =
                            Message.fromJson(snapshot.data!.docs[index]);
                        return email == message.email
                            ? SendChatBubble(
                                message: message.text,
                              )
                            : RecieveChatBubble(message: message.text);
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomTextField(
                onSubmitted: (data) {
                  addMessage(data);
                  scrollDown();
                },
                hintText: 'send message',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollDown() {
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  Future<void> addMessage(String data) {
    return messages
        .add({'message': data, 'time': DateTime.now(), 'email': email});
  }
}

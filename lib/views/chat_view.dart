import 'package:chatting_app/constants.dart';
import 'package:chatting_app/models/message.dart';
import 'package:chatting_app/widgets/recieve_chat_bubble.dart';
import 'package:chatting_app/widgets/send_chat_bubble.dart';
import 'package:chatting_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  static String id = 'chat view';

  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late CollectionReference messages;
  late String myEmail;
  late String theirEmail;
  late String theirUsername;
  late String chatId;
  final ScrollController _controller = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    myEmail = args['myEmail'] as String;
    theirEmail = args['theirEmail'] as String;
    theirUsername = args['theirUsername'] as String;
    chatId = args['chatId'] as String;

    messages = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kCardColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.person_rounded,
              color: kSecondryColor,
            ),
            const SizedBox(width: 10),
            Text(
              theirUsername,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
                        Message message = Message.fromJson(
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>);
                        final DateTime date = message.date.toDate();
                        final String formattedTime =
                            "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

                        return myEmail == message.email
                            ? SendChatBubble(
                                message: message.text,
                                time: formattedTime,
                              )
                            : RecieveChatBubble(
                                message: message.text,
                                time: formattedTime,
                                senderEmail: theirUsername,
                              );
                      },
                    );
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomTextFormField(
                controller: _messageController,
                hintText: 'send message',
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (data) {
                  if (data.trim().isNotEmpty) {
                    addMessage(data);
                    _messageController.clear();
                    scrollDown();
                  }
                },
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: kSecondryColor),
                  onPressed: () {
                    final data = _messageController.text;
                    if (data.trim().isNotEmpty) {
                      addMessage(data);
                      _messageController.clear();
                      scrollDown();
                    }
                  },
                ),
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
        .add({'message': data, 'time': DateTime.now(), 'email': myEmail});
  }
}

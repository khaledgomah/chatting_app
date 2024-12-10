import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final Timestamp date;
  final String email;

  Message({required this.text, required this.date, required this.email});
  factory Message.fromJson(json) {
    return Message(text: json['message'], date: json['time'], email: json['email']);
  }
}

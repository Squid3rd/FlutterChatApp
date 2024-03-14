// import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/textfieldcomp.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/services/chatSer/chat_service.dart';

class MyChatPage extends StatelessWidget {

  final String receiverEmail;
  final String receiverID;

  MyChatPage({super.key, required this.receiverEmail, required this.receiverID});

  // Text Controller
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Send message
  void sendMessage() async {
    // if there is something inside the text field
    if (_messageController.text.isEmpty){
      // send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      // clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail)),
      body: Column(children: [
        // display chat
        Expanded(child: _buildMessageList()),

        // user input
        _buildUserInput(),
      ]),
    );
  }

  // Message Widget
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(receiverID, senderID), builder: (context, snapshot){
      // errors
      if (snapshot.hasError){
        return const Text("Error Input Message");
      }

      // loading
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading send Message ....");
      }


      // return list view

      return ListView(
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
      );
    });
  }

  // Build message Item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Text(data["message"]);
  }

  // build message input
  Widget _buildUserInput(){
    return Row(children: [
      // Text Field
      Expanded(child: TextFieldComp(
        controller: _messageController,
        hinttext: "Type your message",
        obscureText: false, 
      ),),

      // Button Send
      IconButton(
        onPressed: sendMessage,
        icon: const Icon(Icons.arrow_upward)
      )


    ],);
  }
}
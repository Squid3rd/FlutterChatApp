// import 'dart:js';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutterchatapp/components/user_title.dart';
import 'package:flutterchatapp/pages/chat_page.dart';
import 'package:flutterchatapp/services/auth/auth_service.dart';
import 'package:flutterchatapp/components/my_drawer.dart';
import 'package:flutterchatapp/services/chatSer/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();



  void logout(){
    //  get auth
    final _auth = AuthService();
    _auth.signOut();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page Chat"),

      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of User Except for the current
  Widget _buildUserList() {
    return StreamBuilder(builder: (context, snapshot){
      // error
      if (snapshot.hasError){
        return const Text("Error Data");
      }

      // loading
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading...");
      }

      // list view
      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
      );
    }, stream: _chatService.getUsersStream(),);
  }

  // Build Individual list 
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    // Display all user except for the current
    if (userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      onTap: (){
        // tap go chat
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyChatPage(
          receiverEmail: userData["email"],
          receiverID: userData["uid"],
        )));
      },
    );
    }
    else {
      return Container();
    }

  }

}

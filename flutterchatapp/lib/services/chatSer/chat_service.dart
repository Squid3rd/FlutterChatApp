// import 'package:cl';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterchatapp/models/message.dart';
class ChatService {

// Get Auth
final FirebaseAuth _auth = FirebaseAuth.instance;

// Get Instance firestore
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Data Get
/*

List<Map<String,dynamic> = [

{
  'email' : 'test1@gmail.com',
  'id' : ...
},
{
  'email' : 'test2@gmail.com',
  'id' : ...
}
]

*/

// get user stream
Stream<List<Map<String,dynamic>>> getUsersStream(){
  return _firestore.collection("Users").snapshots().map((snapshot){
    return snapshot.docs.map((doc) {
      final user = doc.data();

      // return
      return user;
    }).toList();
  });
}

//  send message
Future<void> sendMessage(String receiverID, message) async {
  // get current user info
  final String currentUserID = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email!;
  final Timestamp timestamp = Timestamp.now();

  // create a new message
  Message newMessage = Message(senderID: currentUserID, senderEmail: currentUserEmail, receiverID: receiverID, message: message, timestamp: timestamp);

  // construct chat room ID for 2 user
  List<String> ids = [currentUserID, receiverID];
  ids.sort(); // sort check 2 people in this chat

  String chatRoomID = ids.join("_");

  // add new message to database
  await _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").add(newMessage.toMap());

}
  //  get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    // construct a chat room
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp", descending: false).snapshots();
  } 

  // getMessages(String receiverID, String senderID) {}


}
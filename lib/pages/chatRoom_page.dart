
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/chat_page.dart';
import 'package:proyecto_poo/providers/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/widgets/principal_bar_widget.dart';

class ChatRoomPage extends StatefulWidget {
  final String name;
  ChatRoomPage(this.name);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState(name);
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  String _name;

  _ChatRoomPageState(this._name); 

  Stream<QuerySnapshot> _chatRoomList;
  String _userName= '';

  @override
  void initState() {
    setState(() {
      this._chatRoomList = DatabaseService().getChatRoom(this._name);
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    _userName = Provider.of<User>(context).name;

    return  chatRoomList();
    
    
  }

  Widget chatRoomList(){
  return StreamBuilder(
    stream: this._chatRoomList,
    builder: (context, snapshot) {
      return snapshot.hasData?ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          return chatRoomTile(
            snapshot.data.documents[index].data['chatRoomId'] );
        },
        ):Container();
    },
    );
}

  Widget chatRoomTile(String chatRoomId) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatPage(chatRoomId)),
  );
      },
        child: Container(
         
          padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(chatRoomId.replaceAll('_', '').replaceAll(this._userName, '').substring(0,1), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.deepPurple
              ),
            ),
            SizedBox(width: 20,),
            Text(chatRoomId.replaceAll('_', '').replaceAll(this._userName, ''), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
          ],
        ),
      ),
    );

  }
}

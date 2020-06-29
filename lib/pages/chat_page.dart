import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/providers/database_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String _chatRoomId;
  ChatPage(this._chatRoomId);

  @override
  _ChatPageState createState() => _ChatPageState(this._chatRoomId);
}

class _ChatPageState extends State<ChatPage> {
  String _chatRoomId;
  Stream chatMessagesStream;
  User user;
  TextEditingController controller = new TextEditingController();
  ScrollController controllerScroll = ScrollController();
  @override
  void initState() { 
      setState(() {
        chatMessagesStream = DatabaseService().getConversationMessage(this._chatRoomId);
        /*controllerScroll.addListener(() { 
          if(controllerScroll.position.pixels == controllerScroll.position.maxScrollExtent){
            controllerScroll.position.moveTo(100);
          }
        });*/
      });
  
    super.initState();
  }
   _ChatPageState(this._chatRoomId);
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${this._chatRoomId.replaceAll('_', '').replaceAll(user.name, '')}'),
        leading: Icon(Icons.account_circle,color: Colors.white,size: 40,),
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            chatMessageList(),
            Container(
              padding: EdgeInsets.symmetric(horizontal:20 ,vertical: 30),
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
          
                        controller: controller,
                        maxLines: 3,
                        minLines: 1,
                      
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),

                          suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: (){
                            onSummited(context);
                          })
                          
                        ),

                      )
                      ),
                    
                  ],
                ),
              ),
            ),
            
            
          ],
        ),
      )
      

    );
  }

  void onSummited(BuildContext context){
    if(this.controller.text.isNotEmpty){
      user.sendMessage(this.controller.text, this._chatRoomId);
      setState(() {
  
       /* this.controllerScroll.animateTo(this.controllerScroll.position.pixels+80,
         duration: Duration(milliseconds: 200),
          curve: Curves.bounceInOut);*/
      
      this.controller.clear();
    });

    }
    
  }

  Widget chatMessageList(){
    return Expanded(
          child: StreamBuilder(
        stream: this.chatMessagesStream,
        builder: (context, snapshot) {
          return  snapshot.hasData?ListView.builder(
            reverse: true,
            controller: this.controllerScroll,
            scrollDirection: Axis.vertical,
            dragStartBehavior: DragStartBehavior.down,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return messageTile(snapshot.data.documents[index].data['message'],
              snapshot.data.documents[index].data['sendBy'] == context.watch<User>().name?true:false,snapshot.data.documents[index].data['date'] ,context);
            },
            ): Container();
        },
        ),
    );
  }

  Widget messageTile( String message, bool isSendByMe,String date, BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: isSendByMe?0:20,right: isSendByMe?10:0,top: 10 ),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe? Alignment.bottomRight:Alignment.bottomLeft ,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
       
        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Text(message, style: TextStyle(color: Colors.white),),
            SizedBox(width:10),
            Text(date.substring(11,16), style: TextStyle(fontSize: 11,color: Colors.grey[300]),textAlign: TextAlign.right)
          ],
        ),
        decoration: BoxDecoration(
          color: isSendByMe?Colors.blue:Colors.grey[500],
          borderRadius:  BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(isSendByMe?20:0), bottomRight: Radius.circular(isSendByMe?0:20)
          )
        ),
      ),
    ); 

  }
}
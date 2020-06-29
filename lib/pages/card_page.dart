

import 'package:flutter/material.dart';
import 'package:proyecto_poo/models/chat.dart';
import 'package:proyecto_poo/models/publication.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/chatRoom_page.dart';
import 'package:proyecto_poo/pages/chat_page.dart';


class CardPage extends StatefulWidget {
  final Publication publication;
  CardPage( this.publication);

  @override
  _CardPageState createState() => _CardPageState(this.publication);
}

class _CardPageState extends State<CardPage> {
  Publication _publication;
  List<String> _options = ["Donación","Trueque","Otro"];
  int _selection ;
  String _message;
  final formKey = GlobalKey<FormState>();
  _CardPageState(this._publication);

  
  
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Publicacion de ${this._publication.userName}"),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                        Color.fromRGBO(208, 208, 255, 0.2),
                        Color.fromRGBO(255, 255, 255, 0.2)
                          ])

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(this._publication.title, style: TextStyle(color: Colors.blue[800],fontSize: 30)),
                  SizedBox(height:10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: FadeInImage(
                      fadeInCurve: Curves.easeInSine,
                      width: 500,
                      height: 400,
                      fit: BoxFit.contain,
                      placeholder: AssetImage('assets/jar-loading.gif'), 
                      image: NetworkImage(this._publication.imageUrl)
                      ),
                  ),
                  Text(this._publication.subTitle, style: TextStyle(color: Colors.blueGrey[800], fontStyle: FontStyle.italic,)),
                  SizedBox(height:20),
                  Container( 
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child:Text(this._publication.content, style: TextStyle(fontSize: 20, color: Colors.black54),)),
                  interactionWidgets(user, this._publication.userName),
                  SizedBox(height: 40),
                  
                  
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget radioList(){
    List<Widget> buttons = List();
    buttons.add(
      Text("Cómo desea ayudarle a ${this._publication.userName}: ", style: TextStyle(fontSize: 20, color: Colors.deepPurple),)
    );
    for(int i = 0; i< this._options.length;i++){
      buttons.add(
        ListTile(
        title: Text(this._options[i]),
        leading:  Radio(
          value: i,
          groupValue: this._selection,
          onChanged: (int value){
            setState(() {
              this._selection = value;
            });
          },
        ), 
                )
      );

    }
  return Column(
    children: buttons,
  );
}

Widget formMessage(){
  return Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
          icon: Icon(Icons.message, color: Colors.deepPurple),
          labelText: 'Escríbele un mensaje a ${this._publication.userName}',
        ),
        onSaved: (newValue) => this._message= newValue,
        )
      ],
    ),
  );
}
Widget interactionWidgets(User user, String userName){

  if(user.name != userName){
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
                  radioList(),
                  SizedBox(height:20),
                  formMessage(),
                  SizedBox(height:30),
                  RaisedButton(
                    child: Text("Ofrecer Ayuda", style:TextStyle(color:Colors.white)),
                    color: Colors.blue[300],
                    onPressed: (){
                      formKey.currentState.save();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>AlertDialog(
                          title: Text("Alerta"),
                          content: Text("Está seguro que desea continuar?. Se enviaran sus datos de contacto a ${this._publication.userName}"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: (){
                              
                                
                                Chat chat = new Chat(user.name, this._publication.userName);
                                chat.createChatRoomAndStartConversation();
                                
                                user.sendMessage(this._message, chat.chatRoomId);
                                user.sendMessage('Ví tu publicación', chat.chatRoomId);
                                if(this._selection!=null){
                                   user.sendMessage('te ayudaré con ${this._options[this._selection]}', chat.chatRoomId);
                                }
                                user.sendMessage('estos son mis datos de contacto', chat.chatRoomId);
                                user.sendMessage('${user.email}', chat.chatRoomId);
                                
                                Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(builder: (context) => ChatPage(chat.chatRoomId))
                                         );
                              },
                               child: Text("Ok")
                               ),
                            FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                               child: Text("Cancelar")
                               ),
                          ],
                      ),
                        );
                    }
                    )
      ],

    );
  }
  else{
    return Container();
  }

}
}



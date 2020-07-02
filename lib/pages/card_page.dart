

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
  User user;
  final formKey = GlobalKey<FormState>();
  _CardPageState(this._publication);

  
  
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return  Scaffold(
      /*appBar: AppBar(
        title: Text("Publicacion de ${this._publication.userName}"),
      ),*/
      body:SafeArea(
        bottom: true,
        maintainBottomViewPadding: true,

        
          child: CustomScrollView(
          
          scrollDirection: Axis.vertical,

          slivers: <Widget>[
            _crearAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10,),
                  _image(),
                  _description(context),
                  interactionWidgets(user, this._publication.userName)
                ]

              ),
            ),
          ],
        ),
      )
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
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                        ),
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
                    ),
                    SizedBox(height: 50)
      ],

    );
  }
  else{
    return Container();
  }

}

Widget _description(BuildContext context){
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        child: Text(this._publication.subTitle,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.subtitle2,
    
        ),
      ),
      Container(
        child: Text(this._publication.date.substring(0,19),
        style: TextStyle(
         fontStyle: FontStyle.italic 
        ),

        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Text(
          this._publication.content,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    ],
  );

}

Widget _image(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    width: MediaQuery.of(context).size.width*0.7,
    height: MediaQuery.of(context).size.height*0.4,
    
    child: Hero(
        tag: this._publication.id,
        child: ClipRRect(

        borderRadius: BorderRadius.circular(100),
        child: FadeInImage(
          width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.4,
          
          fadeInCurve: Curves.easeInSine,
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/jar-loading.gif'), 
          image:NetworkImage(this._publication.imageUrl)
           ),
      ),
    ),
  );
}

 Widget _crearAppBar() {
   return SliverAppBar(
     
     elevation: 2.0,
     backgroundColor: Colors.indigoAccent,
     expandedHeight: 200,
     floating: false,
     pinned: false,
     title: Text('Publicación de ${this._publication.userName}'),
     flexibleSpace: FlexibleSpaceBar(
       centerTitle: true,
       title: SingleChildScrollView(
                child: Column(
           mainAxisAlignment: MainAxisAlignment.end,
           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             IconButton(icon: Icon(Icons.account_circle, size: 50,color: Colors.white,), onPressed: (){}),
             SizedBox(height: 10,),
             Text('${this._publication.title}',
                  style: TextStyle(color: Colors.white ),
                  overflow: TextOverflow.clip,
                ),
           ],
         ),
       ),
     ),

   );
 }
}



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/chatRoom_page.dart';
import 'package:proyecto_poo/providers/login_state_provider.dart';

class PrincipalBar extends StatelessWidget {
  int hola;
  Widget _actionButton(IconData icon, Function callback)
  {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Icon(icon),
        ),
      onTap: callback          
       );
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 40,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm),
          title: Text('a'),
          ),
         BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('a'),
          ),
         BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text('a'),
          )
      ]
      );
    User user = context.watch<User>();
      
   /* return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _actionButton(Icons.access_time,(){}),
          _actionButton(Icons.home,(){}),
          _actionButton(Icons.chat,(){
            Navigator.push(
             context,
              MaterialPageRoute(builder: (context) => ChatRoomPage(user.name))
            );
          }),
         
        
        ],
      ),
    );*/
  }
}
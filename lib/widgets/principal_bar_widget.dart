import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/providers/login_state_provider.dart';

class PrincipalBar extends StatelessWidget {

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
    /*return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm)
          ),
         BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm)
          ),
         BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm)
          )
      ]
      );*/
    
    
    
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _actionButton(Icons.access_time,(){}),
          _actionButton(Icons.assistant,(){}),
          _actionButton(Icons.accessibility,(){}),
         
        
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:proyecto_poo/models/publication.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/chatRoom_page.dart';
import 'package:proyecto_poo/pages/publicationList.dart';
import 'package:proyecto_poo/pages/swipper_page.dart';
import 'package:proyecto_poo/providers/database_provider.dart';
import 'package:proyecto_poo/providers/login_state_provider.dart';
import 'package:proyecto_poo/widgets/principal_appBar_widget.dart';
import 'package:provider/provider.dart';

import 'package:proyecto_poo/widgets/principal_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   User _user;
  int _selectedOption = 1;
  List<String> _namePages =['','Publicaciones','Chat'];
  
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      this._user = Provider.of<User>(context);
    });

    List<Widget> _widgetOptions = <Widget>[
    SwipperPage(),
    PublicationList(),
    ChatRoomPage(_user.name),
    
  ];
    return StreamProvider<List<Publication>>(
      initialData: [],
      create: (context) => DatabaseService().publications,
      child: Scaffold(
        appBar: AppBar(
          
          leading: IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 50,
              ),
              onPressed: () {}),

          centerTitle: true,
          title: Text(this._namePages.elementAt(this._selectedOption)),
          actions: <Widget>[
          
          
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 40,
              ),
              onPressed: () {
                context.read<LoginState>().logout();
              }),
        ]),
        bottomNavigationBar:
            BottomNavigationBar(iconSize: 40, items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text('a'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chats'),
          )
        ],
        currentIndex: this._selectedOption,
        onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'product');
          },
          child: Icon(Icons.create),
        ),
        body: SafeArea(
          child: _widgetOptions.elementAt(this._selectedOption)
          ),
      ),
    );
  }


  void _onItemTapped(int index){
    setState(() {
      this._selectedOption = index;
    });

  }

}

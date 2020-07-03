import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_poo/models/publicationAsk.dart';
import 'package:proyecto_poo/models/publicationHelp.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/chatRoom_page.dart';
import 'package:proyecto_poo/pages/helpList_page.dart';
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
  int _selectedOption = 2;
  List<String> _namePages =['Casos','Ayudas','Publicaciones','Chat'];
  
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      this._user = Provider.of<User>(context);
    });

    List<Widget> _widgetOptions = <Widget>[
    SwipperPage(),
    new HelpList( ),
    new PublicationList(),
    ChatRoomPage(_user.name),
    
  ];
    return MultiProvider(
      providers: [
        StreamProvider<List<PublicationHelp>>(
          create: (context) => DatabaseService().publicationsHelp,
          initialData: [],
          ),
        StreamProvider<List<PublicationAsk>>(
          create: (context) => DatabaseService().publicationsAsk,
          initialData: [],
          ),
        
      ],
  
    
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
            icon: Icon(Icons.assessment),
            title: Text('Casos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            title: Text('Ayudas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chats'),
          ),
          
          
        ],

        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: this._selectedOption,
        onTap: _onItemTapped,
        ),
        floatingActionButton: (this._selectedOption!=0&&this._selectedOption!=3)? FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'product',arguments: this._selectedOption);
          },
          child: Icon(Icons.create),
        ):Container(),
        body: SafeArea(
      
          child: _widgetOptions.elementAt(this._selectedOption)
          ),
        drawerEnableOpenDragGesture: true,
        

      ),
    );
  }


  void _onItemTapped(int index){
    setState(() {
      this._selectedOption = index;

    });

  }

}

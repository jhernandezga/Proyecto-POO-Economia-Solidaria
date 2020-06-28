import 'package:flutter/material.dart';
import 'package:proyecto_poo/models/publication.dart';
import 'package:proyecto_poo/pages/publicationList.dart';
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
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Publication>>(
      initialData: [],
      create:(context)=> DatabaseService().publications,
      child: Scaffold(
        appBar: AppBar(actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 50,
              ),
              onPressed: () {}),
          Expanded(child: SizedBox()),
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 40,
              ),
              onPressed: () {
                context.read<LoginState>().logout();
              }),
        ]),
        bottomNavigationBar: PrincipalBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'product');
          },
          child: Icon(Icons.create),
        ),
        body: PublicationList(),
      ),
    );
  }
}

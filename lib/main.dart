import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/user.dart';

import 'package:proyecto_poo/pages/home_page.dart';
import 'package:proyecto_poo/pages/login_page.dart';
import 'package:proyecto_poo/providers/login_state_provider.dart';
import 'package:proyecto_poo/routes/routes.dart';
import 'package:proyecto_poo/widgets/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: LoginState().user,
          ),
        ChangeNotifierProvider<LoginState>(
          create: (context)=>LoginState()
          ),
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Proyecto POO',
          initialRoute: '/',
          routes: getApplicationRoutes(context),
          
          ),
    );
  }
}

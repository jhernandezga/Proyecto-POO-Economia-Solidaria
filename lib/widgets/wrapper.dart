import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/home_page.dart';
import 'package:proyecto_poo/pages/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      if(context.watch<User>()!=null){
        return HomePage();
      }
      else{
        return LoginPage();
      }
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/pages/chat_page.dart';
import 'package:proyecto_poo/pages/home_page.dart';
import 'package:proyecto_poo/pages/login_page.dart';
import 'package:proyecto_poo/pages/publication_page.dart';
import 'package:proyecto_poo/pages/register_page.dart';
import 'package:proyecto_poo/providers/login_state_provider.dart';
import 'package:proyecto_poo/widgets/wrapper.dart';



Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context)
{
 
  return <String, WidgetBuilder>{
        '/': (BuildContext context )  => Wrapper(),
        'register':(BuildContext context )  => RegisterPage(),
        'product':(BuildContext context )  => PublicationPage(),
        'home':(BuildContext context )  => HomePage(),
        'chat': (BuildContext context )  => ChatPage(),
        };
}
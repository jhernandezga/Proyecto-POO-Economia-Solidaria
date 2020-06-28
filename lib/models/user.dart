

import 'package:proyecto_poo/models/publication.dart';
import 'package:proyecto_poo/providers/database_provider.dart';

class User {

  String uid='';
  String name='';
  String email='';
  String phoneNumber='';
  String photoUrl='';
  int numberPost = 0;

  User({this.uid, this.name, this.email,this.phoneNumber,this.photoUrl});

  bool publish(Publication publication){
    numberPost++;
    DatabaseService db =  new DatabaseService(uid: this.uid);
    db.updateUser(numberPost: numberPost);
    db.postPublication(
    userName: publication.userName,
    title: publication.title,
    subTitle: publication.subTitle, 
    content: publication.content,
    imageUrl: publication.imageUrl,
    date: publication.date,
    );
    return true;
  }

}
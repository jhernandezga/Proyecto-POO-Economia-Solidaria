

import 'package:proyecto_poo/models/publicationAsk.dart';
import 'package:proyecto_poo/models/publicationHelp.dart';
import 'package:proyecto_poo/providers/database_provider.dart';

import 'case.dart';

class User {

  String uid='';
  String name='';
  String email='';
  String phoneNumber='';
  String photoUrl='';
  int numberPost = 0;

  User({this.uid, this.name, this.email,this.phoneNumber,this.photoUrl});

  bool publish(PublicationAsk publication){
    numberPost++;
    DatabaseService db =  new DatabaseService(uid: this.uid);
    db.updateUser(numberPost: numberPost);
    db.postPublication(
    id: '${this.uid}${publication.date}',
    userName: name,
    title: publication.title,
    subTitle: publication.subTitle, 
    content: publication.content,
    imageUrl: publication.imageUrl,
    date: publication.date,
    );
    return true;
  }

  bool publishHelp(PublicationHelp publication){
    DatabaseService db =  new DatabaseService(uid: this.uid);
    db.updateUser(numberPost: numberPost);
    db.postPublicationHelp(
    id: '${this.uid}${publication.date}',
    userName: name,
    title: publication.title,
    subTitle: publication.subTitle, 
    content: publication.content,
    imageUrl: publication.imageUrl,
    date: publication.date,
    contact: publication.contact,
    );
    return true;
  }

  void sendMessage(String message, String chatRoomId){
    DateTime date = DateTime.now();
    Map<String,String> messageMap = {
      'message': message,
      'sendBy': this.name,
      'date': date.toString()
    };
    DatabaseService().addConversationMessages(chatRoomId, messageMap);
  }
  void postCaseUser(Case caseID){
    
    DatabaseService().postCase(
      id:  caseID.id,
      contentCase: caseID.contentCase,
      imageUrl:  caseID.imageUrl,
      date: caseID.date
    );

  }

}
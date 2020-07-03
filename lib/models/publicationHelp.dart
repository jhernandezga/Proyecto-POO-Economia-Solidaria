
import 'package:proyecto_poo/models/publicationAsk.dart';

class PublicationHelp extends PublicationAsk{

 
  int likes ; 
  String contact;
  String id;
  String title;
  String subTitle;
  String content;
  String date;
  String imageUrl;
  String userName;


  PublicationHelp({this.id,this.title, this.subTitle,this.content,this.imageUrl,this.userName, this. contact,this.likes = 0}){
    DateTime time = DateTime.now();
    date = time.toString();
  }


}
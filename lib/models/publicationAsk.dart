


import 'package:flutter/cupertino.dart';

class PublicationAsk{

  String id;
  String title;
  String subTitle;
  String content;
  String date;
  String imageUrl;
  String userName;
  Image image;

  PublicationAsk({this.id,this.title, this.subTitle,this.content,this.imageUrl,this.userName, this.image}){
    DateTime time = DateTime.now();
    date = time.toString();
  }


}



import 'package:flutter/cupertino.dart';

class Publication{

  String id;
  String title;
  String subTitle;
  String content;
  String date;
  String imageUrl;
  String userName;
  Image image;

  Publication({this.id,this.title, this.subTitle,this.content,this.imageUrl,this.userName, this.image}){
    DateTime time = DateTime.now();
    date = time.toString();
  }


}
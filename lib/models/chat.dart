import 'dart:core';

import 'package:flutter/material.dart';
import 'package:proyecto_poo/providers/database_provider.dart';


class Chat{

  String _chatRoomId;
  String _myUserName;
  String _userName;

  Chat(this._myUserName,this._userName){
    this._chatRoomId = _createChatRoomId(this._myUserName, this._userName);
  }

void createChatRoomAndStartConversation(){

  List<String> users = [this._userName,this._myUserName];
  Map<String, dynamic> chatRoomMap = {
    'users':users,
    'chatRoomId':_chatRoomId
  };
  DatabaseService().createChatRoom(this._chatRoomId, chatRoomMap);
}


String _createChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }

}

String get chatRoomId => this._chatRoomId;

}
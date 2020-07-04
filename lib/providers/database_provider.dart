
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_poo/models/case.dart';
import 'package:proyecto_poo/models/publicationAsk.dart';
import 'package:proyecto_poo/models/publicationHelp.dart';
import 'package:proyecto_poo/models/user.dart';


class DatabaseService{

  final String uid;
  
  DatabaseService({this.uid});
  bool chargin = false;

  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference publicationCollection = Firestore.instance.collection('publications');
  final CollectionReference publicationCollectionHelp = Firestore.instance.collection('publicationsHelp');



  Future createUser({String name, String email, String phoneNumber='',String photoUrl='',int numberPost=0 }){
    return userCollection.document(uid).setData({
      'name': name,
      'email':email,
      'phoneNumer':phoneNumber,
      'photoUrl':'',
      'numberPost':numberPost
    }
      
    );    
  }


  Future updateUser({String name, String email, String phoneNumber='',String photoUrl='',int numberPost }){
   
      return userCollection.document(uid).updateData({
    
      'numberPost':numberPost});
    
      

    }

  

  Future postPublication({String id,String title, String subTitle, String content='', String imageUrl='', String date, String userName}){
    
    return publicationCollection.document('$date $uid').setData(
      {
        'id':id,
        'userName':userName,
        'title':title,
        'subTitle':subTitle,
        'content':content,
        'imageUrl':imageUrl,
        'date': date
      }
    );
   

  }


  List<PublicationAsk> _publicationAskFromSnapshot(QuerySnapshot snapshot){
    
    if(this.chargin) return [];
    this.chargin = true;
    List<PublicationAsk> resp = snapshot.documents.map((doc){
      return PublicationAsk(
        id: doc.data["id"]??'' ,
        userName: doc.data["userName"]??'',
        title: doc.data['title']??'',
        subTitle: doc.data['subTitle']??'',
        content: doc.data['content']??'',
        imageUrl: doc.data['imageUrl']??''
      );
    }
    ).toList();
    this.chargin = false;
    return resp;
  }

  Stream<List<PublicationAsk>> get publicationsAsk{
    return  this.publicationCollection.orderBy('date',descending: true)
    .snapshots().map(_publicationAskFromSnapshot);
  }
  


  Future postPublicationHelp({String id,String title, String subTitle, String content='', String imageUrl='', String date, String userName, String contact}){
    
    return publicationCollectionHelp.document('$date $uid').setData(
      {
        'id':id,
        'userName':userName,
        'title':title,
        'subTitle':subTitle,
        'content':content,
        'imageUrl':imageUrl,
        'date': date,
        'contact':contact,
        'likes':0
      }
    );
   
  }

  Future postCase({String id,String contentCase, String imageUrl, String date}){
    return Firestore.instance.collection('cases').document('$date $uid').setData(
      {
        'id':id,
        'contentCase':contentCase,
        'imageUrl':imageUrl,
        'date':date
      }
    );
  }

  List<Case> _casesFromSnapshot(QuerySnapshot snapshot){
    List<Case> resp = snapshot.documents.map((doc){
      return Case(
        id: doc.data['id']??'',
        contentCase: doc.data['contentCase']??'',
        imageUrl: doc.data['imageUrl']??'',
      );
    }).toList();
    return resp;
  }

  Stream<List<Case>> get cases{
    return Firestore.instance.collection('cases').orderBy('date',descending: true)
    .snapshots().map((_casesFromSnapshot));
  }


  List<PublicationHelp> _publicationHelpFromSnapshot(QuerySnapshot snapshot){

    List<PublicationHelp> resp = snapshot.documents.map((doc){
      return PublicationHelp(
        id: doc.data["id"]??'' ,
        userName: doc.data["userName"]??'',
        title: doc.data['title']??'',
        subTitle: doc.data['subTitle']??'',
        content: doc.data['content']??'',
        imageUrl: doc.data['imageUrl']??'',
        contact: doc.data['contact']??'',
        likes: doc.data['likes']??''
      );
    }
    ).toList();
  
    return resp;
  }

  Stream<List<PublicationHelp>> get publicationsHelp{
    return  this.publicationCollectionHelp.orderBy('date',descending: true)
    .snapshots().map(_publicationHelpFromSnapshot);
  }


  createChatRoom(String chatRoomId,  chatRoomMap){

    Firestore.instance.collection("chatRooms")
    .document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
    

  }
  
  proof(String chatRoomId) {
   getConversationMessage(chatRoomId).last.then((value) => print(value.documents.length));
    

   

  }

  addConversationMessages( String chatRoomId, messageMap){
    Firestore.instance.collection("chatRooms")
    .document(chatRoomId)
    .collection("chats")
    .add(messageMap).catchError((e){print(e.toString());});
  }

  Stream<QuerySnapshot> getConversationMessage(String chatRoomId) {

    return Firestore.instance.collection("chatRooms")
      .document(chatRoomId)
      .collection("chats")
      .orderBy('date', descending: true)
     .snapshots();
  }

  Future<User> getUserByUserName(String userName) async {
    QuerySnapshot dataUser = await userCollection.where('name', isEqualTo: userName)
                  .getDocuments();

    return User(
      name: dataUser.documents[0].data['name'],
      uid: dataUser.documents[0].documentID,
      email:  dataUser.documents[0].data['email'],
      phoneNumber:  dataUser.documents[0].data['phoneNumber'],
      photoUrl:  dataUser.documents[0].data['photoUrl'],
      
    );
    
  }

  Stream<QuerySnapshot> getChatRoom(String userName){
    return Firestore.instance.collection("chatRooms")
    .where('users', arrayContains: userName)
    .snapshots();
  }


  
}

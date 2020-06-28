
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_poo/models/publication.dart';


class DatabaseService{

  final String uid;
  
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference publicationCollection = Firestore.instance.collection('publications');



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

  

  Future postPublication({String title, String subTitle, String content='', String imageUrl='', String date, String userName}){
    
    return publicationCollection.document('$date $uid').setData(
      {
        'userName':userName,
        'title':title,
        'subTitle':subTitle,
        'content':content,
        'imageUrl':imageUrl,
        'date': date
      }
    );
   

  }


  List<Publication> _publicationFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Publication(
        userName: doc.data["userName"]??'',
        title: doc.data['title']??'',
        subTitle: doc.data['subTitle']??'',
        content: doc.data['content']??'',
        imageUrl: doc.data['imageUrl']??''
      );

    }
    ).toList();
  }

  Stream<List<Publication>> get publications{
    return  this.publicationCollection.snapshots().map(_publicationFromSnapshot);
  }

}

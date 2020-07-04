import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/case.dart';
import 'package:proyecto_poo/models/user.dart';


class CasePage extends StatefulWidget {

final chatRoomID;
CasePage(this.chatRoomID);

  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  File _image;
  final picker = ImagePicker();
  String optionalText = '';
  TextEditingController controller2 = new TextEditingController();
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return  Container(
        
        
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 50,vertical: 200),

          child: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                          child: Column(

               mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Publica un caso',style: Theme.of(context).textTheme.title,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(                    
                        controller: controller2,
                        autofocus: false,
                        maxLines: 4,
                        minLines: 1,
                        maxLength: 50,
                        decoration: InputDecoration(
                          labelText: 'Caso',
                       
                        
                          
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera),
                        onPressed: ()async{
                          await _getImage(ImageSource.gallery);
  
                        }
                        ),
                      _uploadedImage(),
                      Text(this.optionalText, style: TextStyle(color: Colors.red),),
                      buttonSubmit(),
                    ],
                ),
                  ),
                ]
              ),
            ),
          ),
        ),
      );
  }

  Future<File> _getImage( ImageSource source) async {
    try {
      var tempImage = await picker.getImage(source: source,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 40
      );
      this.optionalText = '';
      setState(() {
   
        _image = File(tempImage.path);
        return _image;
      });
    } catch (e) {
      return _image;
    }
  }

  Widget _uploadedImage() {
    if (this._image == null) {
      return Container();
    } else {
      return Container(
         
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Card(
                child: Image.file(this._image,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height*0.2,
                width: MediaQuery.of(context).size.width*0.7,
                ),
              )));
    }
  }

Widget buttonSubmit(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
     
        FlatButton(
        onPressed: (){
            Navigator.pop(context);
        }, 
        child: Text('Cancelar', style: TextStyle(color:Colors.blue),)
        ),
         FlatButton(
        onPressed: (){
          _submmit();
        }, 
        child: Text('Subir',style: TextStyle(color:Colors.blue))
        ),
    ],
  );

}

void _submmit()async{
  if(this.controller2.text.isNotEmpty && this._image != null){
    String url = await uploadStatusImage();
    user.postCaseUser(Case(
      id: widget.chatRoomID,
      contentCase: this.controller2.text,
      imageUrl: url,
    ));
    Navigator.pop(context);
  }
  if(this.controller2.text.isEmpty ){
    setState(() {
      optionalText = 'Por favor escribe el caso';
    });
  }
  if(this._image == null){
    setState(() {
      optionalText = 'Por favor selecciona una imagen';
    });

  }

}

Future<String> uploadStatusImage() async {
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("ImagesCases");
    var timeKey = DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(this._image);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl.toString();
  }

  
}

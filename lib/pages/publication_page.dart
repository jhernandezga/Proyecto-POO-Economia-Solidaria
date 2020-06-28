import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/publication.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/providers/database_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PublicationPage extends StatefulWidget {
  PublicationPage({Key key}) : super(key: key);

  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  final formKey = GlobalKey<FormState>();
  String _titleField = '';
  String _subTitleField = '';
  String _contentField = '';
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Publicar'),
        ),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    _title(),
                    _subTitle(),
                    _content(),
                    _buttonSubmmit(context),
                    _uploadedImage(),
                  ],
                ),
              ),
            )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                _getImage(ImageSource.camera);
              },
              tooltip: "Toma una foto",
              child: Icon(Icons.add_a_photo),
            ),
            SizedBox(height: 20,),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                _getImage(ImageSource.gallery);
              },
              tooltip: "Agrega una Imagen",
              child: Icon(Icons.add_photo_alternate),
            ),
          ],
        ));
  }

  Widget _title() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Título',
              textAlign: TextAlign.left,
            ),
            TextFormField(
              maxLength: 25,
              decoration: InputDecoration(
                  icon: Icon(Icons.accessibility_new), hintText: 'Título'),
              validator: (value) =>
                  value.isEmpty ? 'Este campo no puede estar vacío' : null,
              onSaved: (newValue) => this._titleField = newValue,
            )
          ],
        ));
  }

  Widget _subTitle() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: <Widget>[
            Text(
              'Subtítulo',
              textAlign: TextAlign.left,
            ),
            TextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Este campo no puede estar vacío' : null,
              maxLength: 100,
              decoration: InputDecoration(
                  icon: Icon(Icons.assignment_late),
                  hintText: 'Lo que necesitas en pocas palabras'),
              onSaved: (newValue) => this._subTitleField = newValue,
            )
          ],
        ));
  }

  Widget _content() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          children: <Widget>[
            Text(
              'Contenido',
              textAlign: TextAlign.start,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              validator: (value) =>
                  value.isEmpty ? 'Este campo no puede estar vacío' : null,
              maxLines: 10,
              minLines: 1,
              maxLength: 400,
              decoration: InputDecoration(
                  icon: Icon(Icons.create),
                  hintText: 'Describe brevemente lo que necesitas'),
              onSaved: (newValue) => this._contentField = newValue,
            )
          ],
        ));
  }

  Widget _buttonSubmmit(BuildContext context) {
    User user = context.watch<User>();
    return RaisedButton(
        child: Text(
          'Publicar',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Colors.blue,
        onPressed: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            if (this._image == null) {
              user.publish(Publication(
                title: this._titleField,
                subTitle: this._subTitleField,
                content: this._contentField,
              ));
            } else {
              String url = await uploadStatusImage();
              user.publish(Publication(
                  userName: user.name,
                  title: this._titleField,
                  subTitle: this._subTitleField,
                  content: this._contentField,
                  imageUrl: url));
              Navigator.pop(context);
            }
          }
        });
  }

  Future<File> _getImage( ImageSource source) async {
    try {
      var tempImage = await picker.getImage(source: source,
      preferredCameraDevice: CameraDevice.rear);
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
          height: 300,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Card(
                child: Image.file(this._image),
              )));
    }
  }

  Future<String> uploadStatusImage() async {
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("ImagesPost");
    var timeKey = DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(this._image);
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl.toString();
  }
}

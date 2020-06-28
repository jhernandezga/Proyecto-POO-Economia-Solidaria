import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/publication.dart';
import 'package:proyecto_poo/models/user.dart';

class PublicationList extends StatefulWidget {
  PublicationList({Key key}) : super(key: key);

  @override
  _PublicationListState createState() => _PublicationListState();
}

class _PublicationListState extends State<PublicationList> {
  @override
  Widget build(BuildContext context) {
    final publications = Provider.of<List<Publication>>(context);
    return ListView.builder(
      
      itemCount: publications.length,
      itemBuilder: (context,index){
        return createCardPost(publications[index], context);
      }
      );
  }

  Widget createCardPost(Publication publication, BuildContext context){
    return Padding(
      padding:EdgeInsets.only(top: 0),
      child: Card(
        child: ListTile(
          onTap: (){},
          title: Text(publication.userName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(publication.title, style: TextStyle(color: Colors.blue[800],fontSize: 15,fontWeight: FontWeight.bold,)),
              buildImage(publication.imageUrl),
              Text(publication.subTitle,style: TextStyle(color: Colors.blueGrey[700], fontStyle: FontStyle.italic),),
              Text(publication.date.substring(0,19)),
              
            ],
          ),


          leading: Icon(Icons.account_circle,size: 30,),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
      );
  }

  Widget buildImage(String url){
    if(url == "" || url == null){
      return Container();
    }else{
      return Container(

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url,scale: 0.5),
                height: 200,
                
                 ),
        )

      ) ;
    }
    
  }
}

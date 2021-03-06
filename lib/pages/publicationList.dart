import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/publicationAsk.dart';
import 'package:proyecto_poo/models/publicationHelp.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/card_page.dart';


class PublicationList extends StatefulWidget {

  PublicationList();
  

  @override
  _PublicationListState createState() {
   
    return _PublicationListState();

  } 
}

class _PublicationListState extends State<PublicationList> {
  
  dynamic publications;

  @override
  Widget build(BuildContext context) {
   
      this.publications = Provider.of<List<PublicationAsk>>(context);
     
    return ListView.builder(
      
      itemCount: publications.length,
      itemBuilder: (context,index){
        return createCardPost(publications[index], context);
      }
      );
  }


  Widget createCardPost(dynamic publication, BuildContext context){
    return Padding(
      padding:EdgeInsets.only(top: 0),
      child: Card(
        child: ListTile(
          onTap: (){
            Navigator.push(
               context,
              MaterialPageRoute(builder: (context) => CardPage(publication),
            ));
          },
          title: header(publication),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              titleText(publication),
              buildImage(publication),
              subTitleText(publication),
              date(publication),
              
              
              
            ],
          ),


          //leading: Icon(Icons.account_circle,size: 30,),
          //trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
      );
  }
  Widget subTitleText(publication)
  {
    return Text(publication.subTitle,style: TextStyle(color: Colors.blueGrey[700], fontStyle: FontStyle.italic),);
  }
  Widget date(publication){
    return Text(publication.date.substring(0,19));

  }

  Widget header(publication){
    return Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.account_circle),onPressed: (){},),
              Text(publication.userName),
            ],
          );
  }

  Widget titleText( publication){
    return Text(publication.title, style: TextStyle(color: Colors.blue[800],fontSize: 15,fontWeight: FontWeight.bold,));
  }
  Widget buildImage( publication){
    String url = publication.imageUrl;
    ImageProvider image;
    
    if(url == "" || url == null){
      return Container();
    }else{
      return Container(

        child: Hero(
          tag: publication.id,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
                  fit: BoxFit.cover ,
                  fadeInCurve: Curves.easeInCirc,
                  fadeOutCurve: Curves.decelerate,
                  fadeInDuration: Duration(milliseconds: 100),
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.height*0.25,
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(url,scale: 0.5),
                  
                
                   )  ,
          ),
        )

      ) ;
    }
    
  }
}

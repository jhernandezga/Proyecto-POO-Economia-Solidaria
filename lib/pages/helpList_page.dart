import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/publicationAsk.dart';
import 'package:proyecto_poo/models/publicationHelp.dart';
import 'package:proyecto_poo/models/user.dart';
import 'package:proyecto_poo/pages/card_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class HelpList extends StatefulWidget {
  @override
  _HelpListState createState() {
    return _HelpListState();
  }
}

class _HelpListState extends State<HelpList> {
  dynamic publications;

  @override
  Widget build(BuildContext context) {
    this.publications = Provider.of<List<PublicationHelp>>(context);

    return Container(
      child: ListView.builder(
          itemCount: publications.length,
          itemBuilder: (context, index) {
            return createCardPost(publications[index], context);
          }),
    );
  }

  Widget createCardPost(PublicationHelp publication, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Card(
        child: ListTile(
          title: header(publication),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              titleText(publication),
              buildImage(publication),
              subTitleText(publication),
              SizedBox(
                height: 10,
              ),
              Text(
                publication.content,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Linkify(
                onOpen: _onOpen,
                text:
                    " Más información en: ${publication.contact}",
                overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              /*Text('Más información en: ',),
                    SizedBox(width: 10,),
                    Text('${publication.contact}',style: TextStyle(color: Colors.blue,),),*/

              SizedBox(
                height: 10,
              ),
              date(publication),
            ],
          ),

          //leading: Icon(Icons.account_circle,size: 30,),
          //trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  Widget subTitleText(publication) {
    return Text(
      publication.subTitle,
      style:
          TextStyle(color: Colors.blueGrey[700], fontStyle: FontStyle.italic),
    );
  }

  Widget date(publication) {
    return Text(publication.date.substring(0, 19));
  }

  Widget header(publication) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
        Text(
          publication.userName,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'publicó una ayuda',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget titleText(publication) {
    return Text(publication.title,
        style: TextStyle(
          color: Colors.blue[800],
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget buildImage(publication) {
    String url = publication.imageUrl;

    if (url == "" || url == null) {
      return Container();
    } else {
      return Container(
          child: Hero(
        tag: publication.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            fit: BoxFit.cover,
            fadeInCurve: Curves.easeInCirc,
            fadeOutCurve: Curves.decelerate,
            fadeInDuration: Duration(milliseconds: 100),
            width: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height * 0.25,
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url, scale: 0.5),
          ),
        ),
      ));
    }
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}

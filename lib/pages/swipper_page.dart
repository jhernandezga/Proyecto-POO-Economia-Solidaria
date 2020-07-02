import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwipperPage extends StatefulWidget {
  SwipperPage({Key key}) : super(key: key);

  @override
  _SwipperPageState createState() => _SwipperPageState();
}

class _SwipperPageState extends State<SwipperPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20,left: 20),
      //width: MediaQuery.of(context).size.width*0.7,
      //height: MediaQuery.of(context).size.height*0.7,
     
      child:  Swiper(
        itemHeight: MediaQuery.of(context).size.height*0.5,
        itemWidth: MediaQuery.of(context).size.width*0.7,
        layout: SwiperLayout.STACK,
        
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: new Image.network("http://via.placeholder.com/350x150",
            fit: BoxFit.fill,));
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
       
    );
  }
}
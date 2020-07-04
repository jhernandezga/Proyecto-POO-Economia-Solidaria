import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_poo/models/case.dart';

class SwipperPage extends StatefulWidget {
  SwipperPage({Key key}) : super(key: key);

  @override
  _SwipperPageState createState() => _SwipperPageState();
}

class _SwipperPageState extends State<SwipperPage> {
  SwiperControl control = new SwiperControl();
  @override
  Widget build(BuildContext context) {
    
    List<Case> cases = Provider.of<List<Case>>(context);
    
    return Container(
      padding: EdgeInsets.only(top: 20,left: 20),
      //width: MediaQuery.of(context).size.width*0.7,
      //height: MediaQuery.of(context).size.height*0.7,
     
      child: (cases.length != 0)? Swiper(
        itemHeight: MediaQuery.of(context).size.height*0.8,
        itemWidth: MediaQuery.of(context).size.width*0.9,
        layout: SwiperLayout.STACK,
        
        itemBuilder: (BuildContext context,int index){
          return Stack(
            fit: StackFit.expand,

            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: new Image.network(cases[index].imageUrl,
                fit: BoxFit.fill,)),
                Container(
                  
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20)),
                       child: Container(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           
                           children: <Widget>[
                             Icon(Icons.supervisor_account, color: Colors.white,),
                             SizedBox(width: 20,),
                             Text(cases[index].id.replaceAll('_', ' y '), style: TextStyle(color: Colors.white),),
                           ],
                         ),
                        //color: Color.fromRGBO(0, 0, 0, 0.4),
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            //stops: [0.2,0.6],
                
                            colors: <Color>[
                              Color.fromRGBO(0, 0, 0, 0.7),
                              Color.fromRGBO(0, 0, 0, 0.005)
                            ]
                            )
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.7,),
                      
                      ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),
                       child: Container(child: Text(cases[index].contentCase, style: TextStyle(color: Colors.white),),
                        //color: Color.fromRGBO(0, 0, 0, 0.4),
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            //stops: [0.2,0.6],
                
                            colors: <Color>[
                              Color.fromRGBO(0, 0, 0, 0.7),
                              Color.fromRGBO(0, 0, 0, 0.005)
                            ]
                            )
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          );
        },
        itemCount: cases.length,
        //pagination: new SwiperPagination(),
        control: control,
      ):Container(),
       
    );
  }
}
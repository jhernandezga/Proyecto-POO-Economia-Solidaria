
class Case{
  String id;
  String imageUrl;
  String contentCase;
  String date;

  Case({this.id,this.imageUrl,this.contentCase}){
     DateTime time = DateTime.now();
     date = time.toString();
  }
}



class Publication{

  String id;
  String title;
  String subTitle;
  String content;
  String date;
  String imageUrl;
  String userName;

  Publication({this.title, this.subTitle,this.content,this.imageUrl,this.userName}){
    DateTime time = DateTime.now();
    date = time.toString();
  }


}
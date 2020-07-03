

abstract class Publication {
  String _id;
  String _title;
  String _content;
  String _date;
  String _userName;
  Publication();
  Publication.init(this._id,this._title,this._content,this._date,this._userName);

  String get id => this._id;
  String get title => this._title;
  String get content => this._id;
  String get date => this._id;
  String get userName => this._id;

  void set id(String value) {
    this._id = value;
  }
  void set title(String value) {
    this._title= value;
  }
  void set content(String value) {
    this._content = value;
  }
  void set date(String value) {
    this._date = value;
  }
  void set userName(String value) {
    this._userName = value;
  }
}

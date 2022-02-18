class PostModel{
  String ?name;
  String ?uId;
  String ? image;
  String ? imagePost;
  String ? dateTime;
  String ? text;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.imagePost
  });
  PostModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    imagePost=json['imagePost'];
  }
  Map<String,dynamic>toMap(){
    return {
      'name': name,
      'uId': uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'imagePost':imagePost,



    };
  }
}
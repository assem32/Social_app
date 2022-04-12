class PostModel{
  String ?name;
  String ?uId;
  String ? image;
  String ? imagePost;
  String ? dateTime;
  String ? text;
  String ? bio;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.imagePost,
    this.bio
  });
  PostModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    imagePost=json['imagePost'];
    bio=json['bio'];
  }
  Map<String,dynamic>toMap(){
    return {
      'name': name,
      'uId': uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'imagePost':imagePost,
      'bio':bio,



    };
  }
}
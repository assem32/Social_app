class PostModel{
  String ?name;
  String ?uId;
  String ? image;
  String ? imagePost;
  String ? dateTime;
  String ? text;
  String ? bio;
  String ? postId;
  int? commentNum;
  int? likesNum;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.imagePost,
    this.bio,
    this.postId,
    this.commentNum,
    this.likesNum
  });
  PostModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    imagePost=json['imagePost'];
    bio=json['bio'];
    postId=json['postId'];
    commentNum=json['commentNum'] ??0;
    likesNum=json['likesNum'] ??0;
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
      'postId':postId,
      'commentNum':commentNum,
      'likesNum':likesNum,
    };
  }
}
class SocialModel{
    String ?name;
    String ? mail;
    String ?uId;
    String ?phone;
   String ? image;
   String ? bio;
   String ?cover;
    bool ?isMailVer;
   SocialModel({
     this.name,
     this.mail,
     this.uId,
     this.phone,
     this.image,
     this.bio,
     this.cover,
     this.isMailVer,

});
    SocialModel.fromJson(Map<String,dynamic>? json){
      mail = json!['mail'];
      name=json['name'];
      uId=json['uId'];
      phone=json['phone'];
      image=json['image'];
      bio=json['bio'];
      cover=json['cover'];
      isMailVer=json['isMailVer'];

    }
    Map<String,dynamic>toMap(){
      return {
        'name': name,
        'mail': mail,
        'uId': uId,
        'image':image,
        'cover':cover,
        'bio':bio,
        'phone': phone,
        'isMailVer':isMailVer,
      };
   }
}
import 'package:firebase/component/styel/iconbroken.dart';
import 'package:firebase/model/add_post.dart';
import 'package:firebase/model/comment.dart';
import 'package:firebase/model/social_model.dart';
import 'package:firebase/modules/profile/profile.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width =double.infinity,
  //Color backGround=Colors.blue,
  double radius=3.0,
  required Function function,
  required String text,
}) =>Container(
  width: width,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
      //color: backGround,
    color: Colors.blue
  ),
  child: MaterialButton(
    onPressed: (){
      function();
    },
    child: Text(text),
  )
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPass=false,
  required Function(String) validate,
  required String label,
  required IconData prefix,
  IconData ?suffix,
  Function ?suffixPressed,
  bool isClickable = true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPass,//what makes the password appear or be astrisk
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  onChanged: (s){
     onChange!(s);
   },
 // onTap: (){
  //  onTap!();
 // }
  //,
   validator: (s){
    return validate(s!);
   },
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix!=null
        ?IconButton(onPressed: (){
          suffixPressed!();
    },
        icon: Icon(suffix)):null,
      border: OutlineInputBorder()
  ),

);

Widget defaultAppBar({
  required BuildContext context,
  String ?title,
  List <Widget> ?action,
})=>AppBar(
  leading: IconButton(onPressed: (){
    Navigator.pop(context);
  },icon: Icon(IconBroken.Arrow___Left_2),),
  title: Text(title!),
  actions: action,
);

Widget buildComment(CommentModel model) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 25, backgroundImage: NetworkImage('${model.image}')),
        SizedBox(
          width: 5,
        ),
        Text(
          '${model.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            '${model.text}',
          ),
        )
      ],
    );

Widget buildProfileImage(PostModel image) => Container(
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage(
          '${image.imagePost}'
      ),
    ));

Widget searchItem(SocialModel searchModel,context) => InkWell(
  onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile(searchModel)) );
  },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${searchModel.image}'),
          ),
          SizedBox(
            width: 10,
          ),
          Text('${searchModel.name}')
        ],
      ),
    );
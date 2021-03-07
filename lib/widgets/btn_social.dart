import 'package:flutter/material.dart';


class BtnSocial extends StatelessWidget {
  final String image;
  final String text;
  final Color color;
  final Function onPressed;
  BtnSocial({this.image, this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return SizedBox(
      width: size.width * 0.7,
      child: FlatButton(
        onPressed: onPressed,
        splashColor: color,
        highlightColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: color,
        child: Row(
          children: [
            SizedBox(child: Image.asset(image),width: 24,),
            SizedBox(height: 20,child: VerticalDivider(color: Colors.white,),),
            Text(text,style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomLink extends StatelessWidget {
  final CustomText child;
  final VoidCallback? onTap;
  final bool underline;
  final bool allianz;

  CustomLink.caption({Key? key, required String text, this.onTap, this.underline = false, this.allianz = false}) : child = CustomText.caption(text), super(key: key);
  CustomLink.subtitle1({Key? key, required String text, this.onTap,  this.underline = false}) : child = CustomText.subtitle1(text), allianz = false, super(key: key);
  CustomLink.bodyText1({Key? key, required String text, this.onTap,  this.underline = false}) : child = CustomText.bodyText1(text), allianz = false, super(key: key);
  CustomLink.headline4({Key? key, required String text, this.onTap,  this.underline = false}) : child = CustomText.headline4(text), allianz = false, super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if(!underline){
        child.style = child.style.copyWith(color: Colors.blue);
      
      return  InkWell(
        onTap: onTap,
        child: child
      ) ;
    }else{
        child.style = child.style.copyWith(color: Colors.blue, decoration: TextDecoration.underline);
      return  InkWell(
        onTap: onTap,
        child: child
      ) ;
    }        
  }
}
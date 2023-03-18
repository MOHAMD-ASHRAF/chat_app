
import 'package:flutter/material.dart';
import 'package:store_app/core/color_const.dart';
import 'package:store_app/generated/assets.dart';


Widget  ContainerWithImAge(context){
  return  Column(
    children: [
      Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        color: kLightGreenColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imageLogo1,fit: BoxFit.cover,
                height: 110,
                width:110),
            const SizedBox(height: 15,),
            const Text('WhatsApp',style: TextStyle(fontSize: 25,color: Colors.white),),
          ],
        ),
      ),
    ],
  );
}
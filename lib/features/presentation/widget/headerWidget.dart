import 'package:flutter/material.dart';
import 'package:store_app/core/color_const.dart';

class HeaderWidget extends StatelessWidget {
  final String tittle;
  const HeaderWidget({Key? key, required this.tittle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: 20,),
        Container(
          alignment: Alignment.center,
          child:  Text(tittle,style: const TextStyle(
            fontSize: 30,
            color: kPrimaryColor,
            fontWeight: FontWeight.w700,
          ),),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}

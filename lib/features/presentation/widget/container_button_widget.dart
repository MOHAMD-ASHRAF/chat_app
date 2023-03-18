import 'package:flutter/material.dart';
import 'package:store_app/core/color_const.dart';


class ContainerButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const ContainerButtonWidget({Key? key, required this.title,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: kLightGreenColor, borderRadius: BorderRadius.circular(10)),
        child:  Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}

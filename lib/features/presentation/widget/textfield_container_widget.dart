import 'package:flutter/material.dart';
class TextFieldContainerWidget extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? hintText;
  final VoidCallback? iconClickEvent;
  final Color? color;
  final Function(String)? onSubmit;
  const TextFieldContainerWidget({Key? key,this.controller, this.prefixIcon, this.keyboardType, this.hintText, this.iconClickEvent, this.color,  this.onSubmit, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child:  TextFormField(
        validator: (data){
          if(data!.isEmpty){
            return 'feild is requird';
          }
        },
        keyboardType: keyboardType,
        controller: controller,
        onFieldSubmitted: onSubmit,
        decoration:  InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: InkWell(onTap: iconClickEvent,child: Icon(prefixIcon)),
        ),
      ),
    );
  }
}

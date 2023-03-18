
import 'package:flutter/material.dart';

class RowTextWidget extends StatelessWidget {
  final String? title1;
  final String? title2;
  final VoidCallback? onTap;
  final MainAxisAlignment? mainAxisAlignment;

  const RowTextWidget({Key? key, this.title1, this.title2, this.onTap, this.mainAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _rowTextWidget();
  }

  Widget _rowTextWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisAlignment: mainAxisAlignment==null?MainAxisAlignment.start: mainAxisAlignment!,
      children: [
        Text("$title1"),
        InkWell(
            onTap: onTap,
            child: Text(
              "$title2",
              style: const TextStyle(color: Colors.red),
            )),
      ],
    );
  }
}

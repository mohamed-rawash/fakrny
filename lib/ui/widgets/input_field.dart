import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:fakrny/ui/theme.dart';

import '../size_config.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 8, right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 3,
              color: Get.isDarkMode? white: black,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                  ),
                  controller: controller,
                  autofocus: false,
                  readOnly: widget == null? false :true,
                  cursorColor: Get.isDarkMode? Colors.grey[200]: Colors.grey[800],
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              widget?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}

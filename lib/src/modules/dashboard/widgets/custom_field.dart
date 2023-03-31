import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  String text;
  TextEditingController controller;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;

  CustomField(
      {Key? key, required this.text, required this.controller, this.inputFormatters, this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        TextFormField(
          validator: (value){
            if (value!.trim().isEmpty){
              return "";
            }
            return null;
          },
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            border: UnderlineInputBorder(
              borderSide: const BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5),
            ),
            errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
                height: 0
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  const CustomTextField({Key? key, this.hint = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: hint),
    );
  }
}

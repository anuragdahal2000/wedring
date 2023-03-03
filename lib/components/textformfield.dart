import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  final bool obsucure;
  Widget? prefix;
  Widget? suffix;

  final String? Function(String?)? validator;
  MyFormField({
    super.key,
    required this.hint,
    required this.myController,
    required this.obsucure,
    this.validator,
    required this.suffix,
    required this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.86,
      child: TextFormField(
        validator: validator,
        controller: myController,
        obscureText: obsucure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: hint,
            prefixIcon: prefix,
            suffixIcon: suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.purple, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            )),
      ),
    );
  }
}

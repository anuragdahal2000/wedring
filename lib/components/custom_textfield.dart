import 'package:flutter/material.dart';
import 'package:wedring/util/constant.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool forPassword;
  final void Function(String)? onChanged;
  final String? helperText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.validator,
    this.forPassword = false,
    this.onChanged,
    this.helperText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObsecure;
  @override
  void initState() {
    super.initState();
    isObsecure = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.helperText != null
            ? Text(
                widget.helperText!,
                style: kRegular14,
              )
            : const SizedBox(),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: (value) => widget.onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                color: kPrimaryColor1,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0,
            ),
            fillColor: kTeritary2,
            prefixIcon: !widget.forPassword
                ? widget.prefixIcon
                : const Icon(
                    Icons.lock_outline,
                  ),
            suffixIcon: widget.forPassword
                ? IconButton(
                    splashRadius: 16,
                    icon: Icon(
                      widget.obscureText!
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: kRegular14,
          ),
          obscureText: isObsecure,
        ),
      ],
    );
  }
}

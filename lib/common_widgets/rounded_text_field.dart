import 'package:flutter/material.dart';
import 'package:ott_code_frontend/common/color_extension.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String title;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? right;
  final Widget? left;
  final void Function(String)? onChanged; // Added onChanged property

  const RoundedTextField({
    Key? key,
    required this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.right,
    this.left,
    this.onChanged, // Added onChanged property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ApplicationColor.text,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            color: ApplicationColor.cardDark,
            borderRadius: BorderRadius.circular(9),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              left ?? const SizedBox(),
              Expanded(
                child: TextField(
                  style: TextStyle(color: ApplicationColor.subText),
                  controller: controller,
                  autocorrect: false,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  onChanged: onChanged, // Set onChanged callback
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: ApplicationColor.text),
                  ),
                ),
              ),
              right ?? const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}

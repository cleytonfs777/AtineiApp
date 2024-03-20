import 'package:flutter/material.dart';
import 'package:atinei_appl/styles/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.placeholder,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late IconData _toggleIcon;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _toggleIcon = _obscureText ? Icons.visibility : Icons.visibility_off;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
      _toggleIcon = _obscureText ? Icons.visibility : Icons.visibility_off;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          fillColor: AppColors.fundoTextField,
          filled: true,
          hintText: widget.placeholder,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.bordaTextField),
            borderRadius: BorderRadius.circular(5.0),
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(_toggleIcon),
                  onPressed: _togglePasswordVisibility,
                )
              : null,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class  CustomTextField extends StatelessWidget{
 final  TextEditingController controller;
 final String hintText;
 final  IconData prefixIcon;
final bool obscureText; 
final Widget? suffixIcon;
final String? Function(String?)? validator;
const CustomTextField({super.key,required this.controller,required this.hintText,required this.prefixIcon,this.obscureText=false,this.validator,this.suffixIcon,});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator:validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:Icon(prefixIcon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
      )


    );
  }
  }


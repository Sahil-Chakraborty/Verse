import 'package:flutter/material.dart';
import 'package:verse/utils/type_def.dart';

class AuthInput extends StatelessWidget {
  final String label,hintText;final bool isPasswordFeild;
  final TextEditingController controller;
  final ValidatorCallback validatorCallback;
  const AuthInput({required this.label,required this.hintText ,required this.controller,required this.validatorCallback , this.isPasswordFeild= false ,super.key});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      validator: validatorCallback,
      obscureText: isPasswordFeild,
                decoration: InputDecoration(border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey)
                ),
                label: Text(label,style: TextStyle(fontSize: 18),),
                hintText: hintText,hintStyle:TextStyle(fontSize: 18),
                ),
              );
  }
}
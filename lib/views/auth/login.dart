
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:verse/controllers/auth_controller.dart';
import 'package:verse/route/route_names.dart';

import 'package:verse/widget/auth_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState>_form = GlobalKey<FormState>();
  final TextEditingController emailController =  TextEditingController(text:" ");
  final TextEditingController passwordController =  TextEditingController(text:" ");
  final AuthController authController =Get.put(AuthController());

  void submit()
  {
    
    if(_form.currentState!.validate())
    {
      authController.login(emailController.text, passwordController.text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Image.asset("assets/images/logo.png",width: 100,height:100),
                const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                SizedBox(height: 10,),
                AuthInput(label: "Email",hintText: "Enter your email",controller: emailController,validatorCallback: ValidationBuilder().email().build()),
                SizedBox(height:26 ,),
                AuthInput(label: "Password",hintText: "Enter your password",isPasswordFeild:true,controller: passwordController,validatorCallback: ValidationBuilder().required().minLength(6).maxLength(10).build()),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: submit,style: 
                ButtonStyle
                (
                  minimumSize: WidgetStateProperty.all(Size.fromHeight(40),),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
            
                ), 
                child: Text("Submit",style: TextStyle(color: Colors.black,fontSize: 16),),),
                SizedBox(height: 20,),
                Text.rich(TextSpan(children: [TextSpan(text: " Sign up",style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed(RouteNames.register))],
                text: "Dont have an account ?")),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
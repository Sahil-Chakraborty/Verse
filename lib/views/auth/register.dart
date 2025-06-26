import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:verse/controllers/auth_controller.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/widget/auth_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState>_form = GlobalKey<FormState>();
  final TextEditingController nameController =  TextEditingController(text:"");
  final TextEditingController emailController =  TextEditingController(text:"");
  final TextEditingController passwordController =  TextEditingController(text:"");
  final TextEditingController cpasswordController =  TextEditingController(text:"");
  final AuthController controller = Get.put(AuthController());

  void submit()
  {
    if(_form.currentState!.validate())
    {
      controller.register(nameController.text, emailController.text,passwordController.text);
    }
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
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
                          "  Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                SizedBox(height: 10,),
                AuthInput(label: "Name",hintText: "Enter your name",controller: nameController,validatorCallback: ValidationBuilder().required().minLength(3).maxLength(50).build(),),
                SizedBox(height:26 ,),
                AuthInput(label: "Email",hintText: "Enter your email",controller: emailController,validatorCallback: ValidationBuilder().email().build()),
                SizedBox(height:26 ,),
                AuthInput(label: "Password",hintText: "Enter your password",isPasswordFeild:true,controller: passwordController,validatorCallback: ValidationBuilder().required().minLength(6).maxLength(10).build()),
                SizedBox(height: 20,),
                AuthInput(label: "Confirm Password",hintText: "Confirm your password",controller: cpasswordController,isPasswordFeild: true,validatorCallback: (arg){
                  if(  arg!= passwordController.text)
                  {
                    return "password not matched";
                  }
                   return null;
                },),
                SizedBox(height:26 ,),
                Obx(()=>ElevatedButton(onPressed: submit,style: 
                ButtonStyle
                (
                  minimumSize: WidgetStateProperty.all(Size.fromHeight(40),),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
            
                ), 
                child: Text(controller.registerLoading.value?"processing..":"Register",style: TextStyle(color: Colors.black,fontSize: 16),),
                ),),
                SizedBox(height: 20,),
                Text.rich(TextSpan(children: [TextSpan(text: " Sign in",style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed(RouteNames.login))],
                text: "Allready have an account ?")),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
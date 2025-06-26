import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:verse/controllers/profile_controller.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/widget/cirlcle_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController textEditingController = TextEditingController(text: "");
  final ProfileController controller = Get.find<ProfileController>();
  final SupabaseService supabaseService= Get.find<SupabaseService>();
  @override
  void initState() {
   if(supabaseService.currentUser.value?.userMetadata?["description"]!=null) {
    textEditingController.text=supabaseService.currentUser.value?.userMetadata?["description"];
   }
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: 
        Text("Edit profile"),
      
      
      actions: [
        Obx(
          ()=> TextButton(onPressed: (){
            controller.updateProfile(supabaseService.currentUser.value!.id, textEditingController.text);
          }, child:controller.loading.value? SizedBox(height: 14,width: 14,child: CircularProgressIndicator(),): Text("Done",style: TextStyle(fontSize: 20),)),
        )
      ],
     ),
     body:SingleChildScrollView(
      padding: EdgeInsets.all(10),
       child: Column(
        
        children: [
          Obx(
            ()=> Stack(
              alignment: Alignment.bottomRight,
              children: [
                CirlcleImage(
                  radius: 70,
                  file: controller.image.value,
                  url: supabaseService.currentUser.value?.userMetadata?["image"],
                
                ),
                
                IconButton(onPressed: (){
                  controller.pickImage();
                }, icon: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white60,
                  child: Icon(Icons.edit),
                ))
              ],
            ),
          ),
          SizedBox(height: 30,),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(border: UnderlineInputBorder(),
            hintText: "Your Description",
            hintStyle: TextStyle(fontSize: 16),
            label: Text("Description",style: TextStyle(fontSize: 18),),
            ),
          )
        ],
       ),
     )
    );
  }
}
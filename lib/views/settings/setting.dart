import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:verse/controllers/setting_conroller.dart';
import 'package:verse/utils/helper.dart';

class Setting extends StatelessWidget {
  
   Setting({super.key});
  final SettingConroller controller= Get.put(SettingConroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          ListTile(
            onTap: () {
              confirmDialog("Logout","Cancel",controller.logout);
            },
            leading: Icon(Icons.logout),
            title: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            trailing: Icon(Icons.arrow_forward),
          )
        ],
      )),
    );
  }
}
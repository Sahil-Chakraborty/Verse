import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:verse/controllers/thread_controller.dart';

class ThreadImagePriview extends StatelessWidget {
   ThreadImagePriview({super.key});
  final ThreadController controller=Get.find<ThreadController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
                                     padding: const EdgeInsets.only(top: 10),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.file(controller.image.value!,fit: BoxFit.cover,alignment: Alignment.topCenter,),
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 10,
                                            child: CircleAvatar(
                                            backgroundColor: Colors.white38,
                                            child: IconButton(onPressed: (){
                                              controller.image.value=null;
                                            }, 
                                            icon: Icon(Icons.close),),
                                          ),),
                                        ],
                                      ),
                                    );
    }
  }
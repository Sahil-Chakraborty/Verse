import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/sevices/storage_service.dart';
import 'package:verse/utils/helper.dart';
import 'package:verse/utils/storage_keys.dart';
class AuthController extends GetxController
{
  var registerLoading = false.obs;
  var loginLoading = false.obs;
  Future<void> register(String name , String email , String password) async
  {
    try{
      registerLoading.value = true;
    final  AuthResponse data = await Supabase.instance.client.auth.signUp(email: email,password: password, data: {"name":name});
    registerLoading.value= false;
    if (data.user!= null)
    {
      
      StorageService.session.write(StorageKeys.userSession,data.session!.toJson());
      Get.offAllNamed(RouteNames.home);
    }

    } on AuthApiException catch(error)
    {
      loginLoading.value=false;
      showSnackBar("Error", error.message);
    }
  }

  Future<void> login(String email , String password) async
  {
    loginLoading.value=true;
    try{
      
    final  AuthResponse response = await Supabase.instance.client.auth.signInWithPassword(email: email,password: password, );
    loginLoading.value=false;
    if(response.user!=null)
    {
      
      StorageService.session.write(StorageKeys.userSession, response.session!.toJson());
      Get.offAllNamed(RouteNames.home);
    }
  }on AuthException catch(error)
  {
    loginLoading.value=false;
    showSnackBar("Error", error.message);
  }
  }
}
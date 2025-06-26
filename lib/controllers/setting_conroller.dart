import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/sevices/storage_service.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/utils/storage_keys.dart';

class SettingConroller extends GetxController
{
  void logout() async
  {
    StorageService.session.remove(StorageKeys.userSession);
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed(RouteNames.login);
  }
}
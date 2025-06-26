import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:verse/route/route.dart';
import 'package:verse/route/route_names.dart';
import 'package:verse/sevices/storage_service.dart';
import 'package:verse/sevices/supabase_service.dart';
import 'package:verse/theme/theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  Get.put(SupabaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: theme,
      getPages : Routes.pages,
      initialRoute:StorageService.userSession!=null? RouteNames.home: RouteNames.login,
      
    );
  }
}


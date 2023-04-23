import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat/chat_screen.dart';
import 'package:flutter_chat_app/screens/login/login_screen.dart';
import 'package:flutter_chat_app/services/theme_services.dart';
import 'package:flutter_chat_app/shared/constants.dart';
import 'package:flutter_chat_app/shared/themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  await GetStorage.init();
  runApp(
    Provider(
      create: (BuildContext context) {

      },
      child: MyApp()
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  final GetStorage _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeServices().theme;
    Get.changeThemeMode(themeMode);

    return GetMaterialApp(
      theme: Themes.lightThem,
      darkTheme: Themes.darkThem,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: _box.read(Caches.cacheUserId) == null ?  const LoginScreen() : const ChatScreen(),
    );
  }
}
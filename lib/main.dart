import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/controllers/get_all_taks_controller.dart';
import 'package:flutterdummytest/controllers/login_controller.dart';
import 'package:flutterdummytest/views/Tasks/complete_todo_task.dart';
import 'package:flutterdummytest/views/auth/login_screen.dart';
import 'package:flutterdummytest/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool entrypoint = prefs.getBool('entrypoint') ?? false;
  final bool loggedIn = prefs.getBool('loggedIn') ?? false;

  Widget defaultHome = (loggedIn) ? const HomeScreen() : const LoginScreen();

  final loginController = LoginController();
  loginController.entrypoint = entrypoint;
  loginController.loggedIn = loggedIn;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => GetAllTaskController()),
      ],
      child: MyApp(defaultHome: defaultHome),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  const MyApp({super.key, required this.defaultHome});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kLight.value),
            iconTheme: IconThemeData(color: Color(kDark.value)),
            primarySwatch: Colors.grey,
          ),
          home: defaultHome,
        );
      },
    );
  }
}

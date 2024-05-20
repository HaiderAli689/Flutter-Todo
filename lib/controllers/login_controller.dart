import 'package:flutter/material.dart';
import 'package:flutterdummytest/views/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';
import '../services/helper/auth_helper.dart';

class LoginController extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;
  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  Future<void> userLogin(LoginModel model) async {
    final response = await AuthHelper().login(model);
    if (response) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      await prefs.setBool('entrypoint', true);

      Get.snackbar('Sign In Successfully', 'Enjoy your search for a job.',
          colorText: Colors.white,
          backgroundColor: Colors.blue,
          icon: Icon(Icons.check_circle));

      Get.offAll(() => HomeScreen(),
          transition: Transition.fade,
          duration: Duration(milliseconds: 900));
    } else {
      Get.snackbar('Sign In Failed', 'Please check your credentials',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
    }
  }

  Future<void> userLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    loggedIn = false;
    notifyListeners();
  }
}

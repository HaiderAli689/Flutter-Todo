import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdummytest/common/custom_btn.dart';
import 'package:flutterdummytest/common/custom_textfield.dart';
import 'package:flutterdummytest/controllers/login_controller.dart';
import 'package:flutterdummytest/model/login_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(builder: (context, loginNotifier, child){
      return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical:12.h ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  keyboardType: TextInputType.text
              ),
              const SizedBox(height: 12,),
              CustomTextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                hintText: 'Password',
                obscureText: loginNotifier.obscureText,
                validator: (password) {
                  if (password!.isEmpty || password.length < 7) {
                    return 'Please enter a valid password';
                  } else {
                    return null;
                  }
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    loginNotifier.obscureText = !loginNotifier.obscureText;
                  },
                  child: Icon(
                    loginNotifier.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(kDark.value),
                  ),
                ),
              ),

              SizedBox(height: 24,),
              CustomButton(
                  text: 'L O G I N',
                onTap: (){
                    try{
                      LoginModel model = LoginModel(
                          username: usernameController.text,
                          password: passwordController.text,
                      );
                      loginNotifier.userLogin(model);

                      showDialog(context: context, builder: (context){
                        return  Center(
                          child: CircularProgressIndicator(
                            color: kPrimary,
                            backgroundColor: kLight,
                          ),
                        );
                      });
                    } catch (e) {
                      print(e);
                      Get.snackbar('Error', 'An unexpected error occurred',
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: Icon(Icons.error));
                    }
                },
              )
            ],
          ),
        ),
      );
    });
  }
}

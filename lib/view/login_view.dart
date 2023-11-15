import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:CoachZiad/res/components/curvePainter.dart';
import 'package:CoachZiad/res/components/round_button.dart';
import 'package:CoachZiad/utils/routes/routes_name.dart';
import 'package:CoachZiad/utils/utils.dart';
import 'package:CoachZiad/view/home_screen.dart';
import 'package:CoachZiad/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../model/login_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 57, 56, 56),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0.h),
        child: Container(
          height: 500.h,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),

                Container(
                  height: 50.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "رقم الهاتف",
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 50.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "كلمة المرور",
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // const Text(
                //   "تسجيل باستخدام الهاتف",
                //   style: TextStyle(
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                // SizedBox(
                //   height: 5.h,
                // ),

                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                  title: 'Login',
                  loading: authViewMode.loading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      // Utils.flushBarErrorMessage(
                      //     'الرجاء ادخال رقم الهاتف', context);
                    } else if (_passwordController.text.isEmpty) {
                      // Utils.flushBarErrorMessage(
                      //     'الرجاء ادخال الرمز السري', context);
                    } /*else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Please enter 6 digit password', context);

                  }*/
                    else {
                      final requestData = {
                        'phone': _emailController.text.toString(),
                        'password': _passwordController.text.toString(),
                      };

                      // Map data = {
                      //   'username': _emailController.text.toString(),
                      //   'password': _passwordController.text.toString(),
                      // };
                      //  LoginData loginData = LoginData(
                      //   'username': _emailController.text.toString(),
                      //  )

                      // Map data = {
                      //   'email' : 'eve.holt@reqres.in',
                      //   'password' : 'cityslicka',
                      // };

                      authViewMode.loginApi(context, requestData);
                      print('api hit');
                    }
                  },
                ),

                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ليس لديك حساب؟  ",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.gendertype);
                        },
                        child: Text("سجل الان",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color:
                                    const Color.fromARGB(255, 6, 159, 182)))),
                  ],
                ),

                // SizedBox(
                //   height: 44.h,
                //   width: 270.w,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           primary: const Color.fromARGB(255, 30, 99, 196),
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10))),
                //       onPressed: () {
                //         if (_emailController.text.isEmpty) {
                //           Utils.flushBarErrorMessage(
                //               'الرجاء ادخال اسم المستخدم', context);
                //         } else if (_passwordController.text.isEmpty) {
                //           Utils.flushBarErrorMessage(
                //               'الرجاء ادخال الرمز السري', context);
                //         } /*else if(_passwordController.text.length < 6){
                //   Utils.flushBarErrorMessage('Please enter 6 digit password', context);

                // }*/
                //         else {
                //           Map data = {
                //             'username': _emailController.text.toString(),
                //             'password': _passwordController.text.toString(),
                //           };

                //           // Map data = {
                //           //   'email' : 'eve.holt@reqres.in',
                //           //   'password' : 'cityslicka',
                //           // };
                //           print(data);

                //           authViewMode.loginApi(data, context);
                //           print('api hit');
                //         }
                //       },
                //       child: Text("تسجيل الدخول",
                //           style: TextStyle(
                //               fontSize: 18.sp, fontWeight: FontWeight.bold))),
                // )
              ],
            ),
          ),
        ),
      ),

      /*SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (valu) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      focusNode: passwordFocusNode,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_open_rounded),
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value = !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility)),
                      ),
                    );
                  }),
              SizedBox(
                height: height * .085,
              ),
              RoundButton(
                title: 'Login',
                loading: authViewMode.loading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage('Please enter email', context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage('Please enter password', context);
                  } /*else if(_passwordController.text.length < 6){
                    Utils.flushBarErrorMessage('Please enter 6 digit password', context);

                  }*/
                  else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };

                    // Map data = {
                    //   'email' : 'eve.holt@reqres.in',
                    //   'password' : 'cityslicka',
                    // };

                    authViewMode.loginApi(data, context);
                    print('api hit');
                  }
                },
              ),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.signUp);
                  },
                  child: Text("Don't have an accont? Sign Up"))
            ],
          ),
        ),*/
    );
  }
}

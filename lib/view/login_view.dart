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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0.h),
        child: Form(
          key: _formKey,
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
                              padding:
                                  EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "رقم الهاتف",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.red,
                                        content:
                                            Text('الرجاء ادخال رقم الهاتف'),
                                        // You can customize the SnackBar appearance and duration here
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )
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
                        borderRadius: BorderRadius.circular(10)),
                    child: Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "كلمة المرور",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.red,
                                        content:
                                            Text('الرجاء ادخال كلمة المرور'),
                                        // You can customize the SnackBar appearance and duration here
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  RoundButton(
                    title: 'Login',
                    loading: authViewModel.loading,
                    onPress: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final requestData = {
                          'phone': _emailController.text.toString(),
                          'password': _passwordController.text.toString(),
                        };

                        authViewModel.loginApi(context, requestData);
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
                                color: const Color.fromARGB(255, 6, 159, 182))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

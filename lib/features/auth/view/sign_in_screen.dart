import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycle_ai/core/heleprs/validator.dart';
import 'package:recycle_ai/core/router/app_routes_names.dart';
import 'package:recycle_ai/core/service_locator/service_locator.dart';
import 'package:recycle_ai/core/widgets/sizer.dart';
import 'package:recycle_ai/utils/assets/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _name = TextEditingController();
  // final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    _startAutoScroll();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients) {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(_scrollController.offset + 5,
              duration: const Duration(milliseconds: 50), curve: Curves.linear);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().moveX(duration: 1000.ms, begin: -500.w, end: 0),
                  SizedBox(height: 30.h),
                  // Material(
                  //   elevation: 2,
                  //   borderRadius: BorderRadius.circular(20.w),
                  //   child: Container(
                  //     height: 200.h,
                  //     clipBehavior: Clip.hardEdge,
                  //     decoration: BoxDecoration(
                  //       color: lightClr.primaryColor.withOpacity(0.2),
                  //       borderRadius: BorderRadius.circular(20.w),
                  //       // shape: BoxShape.circle,
                  //     ),
                  //     // padding: EdgeInsets.symmetric(vertical: 5.h),
                  //     child: Image.asset(
                  //       AssetsData.onBoarding_5,
                  //       fit: BoxFit.fitHeight,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 100.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      children: [
                        Image.asset(
                          AssetsData.scroll,
                          width: 700.w,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                  Sizer(height: 30.h),

                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) => validator(input: value, label: 'Name', isRequired: true),
                  ).animate().moveX(duration: 1000.ms, begin: -500.w, end: 0),
                  const SizedBox(height: 20),
                  // TextFormField(
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     labelText: "Password",
                  //     prefixIcon: const Icon(Icons.lock_outline),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   validator: (value) => validator(input: value, label: 'Password', isRequired: true),
                  // ),
                  // const SizedBox(height: 10),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       // Handle forgot password
                  //     },
                  //     child: const Text(
                  //       "Forgot Password?",
                  //       style: TextStyle(color: Colors.blue),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        if (_name.text.isNotEmpty) {
                          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.homeScreen, (_) => false);
                          serviceLocator<SharedPreferences>().setBool('auth', true);
                        }
                        // else {
                        // showSnackbar('Error', 'The provided credentials are not valid', true);
                        // }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16),
                    ),
                  ).animate().moveX(duration: 1000.ms, begin: -500.w, end: 0),
                  // const SizedBox(height: 20),
                  // const Row(
                  //   children: [
                  //     Expanded(child: Divider(thickness: 1)),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                  //       child: Text(
                  //         "OR",
                  //         style: TextStyle(color: Colors.grey),
                  //       ),
                  //     ),
                  //     Expanded(child: Divider(thickness: 1)),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // OutlinedButton.icon(
                  //   onPressed: () {
                  //     // Handle Google sign-in
                  //   },
                  //   style: OutlinedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //     side: const BorderSide(color: Colors.grey),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   icon: Icon(MdiIcons.google),
                  //   label: const Text(
                  //     "Sign in with Google",
                  //     style: TextStyle(color: Colors.black, fontSize: 16),
                  //   ),
                  // ),
                  // const SizedBox(height: 40),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       "Don't have an account?",
                  //       style: TextStyle(color: Colors.grey),
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Handle navigation to sign-up screen
                  //       },
                  //       child: const Text(
                  //         "Sign Up",
                  //         style: TextStyle(color: Colors.blue),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

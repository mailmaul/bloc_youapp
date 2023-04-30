import 'dart:convert';
import 'dart:math';

import 'package:bloc_youapp/bloc/login/login_cubit.dart';
import 'package:bloc_youapp/pages/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginCubit controller = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(31, 66, 71, 1),
              Color.fromRGBO(13, 29, 35, 1),
              Color.fromRGBO(9, 20, 26, 1)
            ],
            center: Alignment.topRight,
            radius: 2.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 83, right: 10),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60),
              const Padding(
                padding: EdgeInsets.only(left: 41),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 25),
                child: TextFormField(
                  onChanged: (text) {
                    // controller.setText(text);
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      hintText: ("Enter Username/Email"),
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.4), fontSize: 13)),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 25),
                child: BlocBuilder<LoginCubit, bool>(
                  bloc: controller,
                  builder: (context, state) {
                    return TextFormField(
                      onChanged: (text) {
                        // controller.setText(text);
                      },
                      obscureText: state,
                      controller: passwordController,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.change();
                            },
                            child: Icon(
                              state
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.06),
                          hintText: ("Enter Password"),
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 13)),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 25),
                child: GestureDetector(
                  onTap: () {
                    auth(context);
                  },
                  child: Container(
                    height: 48,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(98, 205, 203, 1),
                            Color.fromRGBO(69, 153, 219, 1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(9),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(98, 205, 203, 0.5),
                            blurRadius: 15,
                            offset: Offset(0, 12),
                          )
                        ]),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 52),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No account?",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const ProfileScreen()),
                        // );
                      },
                      child: GradientText("Register here",
                          gradientType: GradientType.linear,
                          gradientDirection: GradientDirection.ltr,
                          colors: [
                            Color.fromRGBO(148, 120, 62, 1),
                            Color.fromRGBO(243, 237, 166, 1),
                            Color.fromRGBO(248, 250, 229, 1),
                            Color.fromRGBO(255, 226, 190, 1),
                            Color.fromRGBO(213, 190, 136, 1),
                            Color.fromRGBO(248, 250, 229, 1),
                            Color.fromRGBO(213, 190, 136, 1),
                          ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void auth(BuildContext context) async {
    final url =
        'http://techtest.youapp.ai/api/login?email=${emailController.text}&password=${passwordController.text}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Login success
        final responseData = json.decode(response.body);
        // Do something with the response data
        if (responseData['message'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login Succes"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(
                      email: emailController.text,
                    )),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill in the email & password correctly'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        // Login failed
        // Get.snackbar('Login Failed', "Check your internet");
      }
    } catch (error) {
      // Get.snackbar('Error', 'Something went wrong. Please try again later.');
    }
  }
}

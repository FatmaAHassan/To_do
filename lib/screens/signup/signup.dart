import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/layout/home_layout.dart';
import 'package:to_do/providers/my_provider.dart';
import 'package:to_do/screens/login/login.dart';
import 'package:to_do/shared/firebase/firebase_functions.dart';
import 'package:to_do/shared/styles/colors/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  static const String routeName = "SignUp";
  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("SignUp"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text("Name"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: ageController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter yor Age ";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: Text("Age"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter email ";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "please enter valid email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("UserName"),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    obscuringCharacter: "*",
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "please enter valid password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text("Password"),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: primaryColor)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          FirebaseFunctions.signUp(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            int.parse(ageController.text),
                          ).then((value) {
                            pro.initMyUser();
                            Navigator.pushReplacementNamed(
                                context, HomeLayout.routeName);
                          }).catchError((e) {
                            print(e);
                          });
                        }
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      )),
                  Row(
                    children: [
                      Text("I Have an Account ....!"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.routeName, (route) => false);
                          },
                          child: Text("Login "))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

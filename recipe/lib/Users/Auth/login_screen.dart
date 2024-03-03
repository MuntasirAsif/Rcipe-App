import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/Users/Auth/sign_up.dart';
import 'package:recipe/Users/Screen View/category.dart';
import 'package:recipe/Users/Users%20Preferances/users_preferances.dart';
import '../../api_connection/api_connection.dart';
import '../../round_button.dart';
import 'package:http/http.dart' as http;

import '../Model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  loginUserNow()async{
    try{
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email":emailController.text.trim(),
          "user_Password":passwordController.text.trim()
        },
      );
      if(res.statusCode ==200){
        var resBody = jsonDecode(res.body);

        if(resBody['success']==true){
          if (kDebugMode) {
            print('Login SuccessFully');
          }
          User userInfo = User.fromJson(resBody['userData']);
          //save user data in local storage
          await RememberUserPreferances.saveRememberUser(userInfo);
          Get.to(const Catagory());
        }
        else{
          print('Please Enter Correct Email & Password');
          Get.snackbar('Login Failed', 'Please Enter Correct Email & Password',
              backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        }
      }
    }catch(e){
      print("ERROR: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          height: 700,
                        ),
                        Container(
                          height: 500,
                          width: 400,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage('images/bg.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        Positioned(
                          top: 100,
                          right: 130,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                                'images/free-recipe-sheet-clip-art-21.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 50,
                          child: Container(
                            height: 350,
                            width: 300,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(.9),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Sign In',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              controller: emailController,
                                              validator: (val) => val == ""
                                                  ? "please Enter Email"
                                                  : null,
                                              keyboardType:
                                              TextInputType.emailAddress,
                                              autofillHints: const [
                                                AutofillHints.email
                                              ],
                                              style: const TextStyle(color: Colors.white),
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.email_outlined,color: Colors.white,),
                                                hintText: 'E-mail',
                                                hintStyle: const TextStyle(color: Colors.white),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color:
                                                        Colors.white),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20)),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color: Colors
                                                            .white),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(20)),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color: Colors
                                                            .white),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(20)),
                                                disabledBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color: Colors
                                                            .white),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(20)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              controller: passwordController,
                                              validator: (val) => val == ""
                                                  ? "please Enter password"
                                                  : null,
                                              keyboardType:
                                              TextInputType.emailAddress,
                                              autofillHints: const [
                                                AutofillHints.email
                                              ],
                                              style: const TextStyle(color: Colors.white),
                                              decoration: InputDecoration(
                                                hintStyle: const TextStyle(color: Colors.white),
                                                prefixIcon:
                                                const Icon(Icons.password,color: Colors.white,),
                                                hintText: 'E-mail',
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color:
                                                        Colors.white),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20)),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color: Colors
                                                            .white),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(20)),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color: Colors
                                                            .white),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(20)),
                                                disabledBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    const BorderSide(
                                                        color: Colors
                                                            .white),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(20)),
                                              ),
                                            )
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            //validate user emaill
                                            print('ok');
                                            loginUserNow();
                                          }
                                        },
                                        child: const RoundButton(
                                          inputText: 'Login',
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const SignUpScreen()),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.purple),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

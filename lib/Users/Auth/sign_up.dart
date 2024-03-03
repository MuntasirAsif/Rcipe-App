import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/api_connection/api_connection.dart';
import '../../round_button.dart';
import '../Model/user.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  registerAndSaveUserRecord() async {
    int first = Random().nextInt(10000);
    int second = Random().nextInt(10000);
    int third = Random().nextInt(10000);
    int fourth = Random().nextInt(10000);
    int fifth = Random().nextInt(10000);
    int mul = Random().nextInt(1000);
    User userModel = User(
      first + second + third + fourth + fifth + mul,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    try {
      var res = await http.post(
        Uri.parse(API.signup),
        body: userModel.toJson(),
      );
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success'] == true) {
          print('SignUp SuccessFully');
          setState(() {
            emailController.clear();
            nameController.clear();
            passwordController.clear();
          });
        } else {
          print('try again');
        }
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  validateUserEmail() async {
    print(emailController.text.trim());
    try {
      var res = await http.post(Uri.parse(API.validateEmail), body: {
        'user_email': emailController.text.trim(),
      });
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['Email_found'] == true) {
          print('This Email is Already Used');
        } else {
          print('ok');
          registerAndSaveUserRecord();
        }
      }
    } catch (e) {
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
                            height: 400,
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
                                      'Sign Up',
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
                                              controller: nameController,
                                              validator: (val) => val == ""
                                                  ? "please Enter Name"
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
                                                    const Icon(Icons.person,color: Colors.white,),
                                                hintText: 'Name',
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
                                            validateUserEmail();
                                          }
                                        },
                                        child: const RoundButton(
                                          inputText: 'Sign Up',
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
                          "Already have an account? ",
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginScreen()),
                              );
                            },
                            child: const Text(
                              "Login",
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

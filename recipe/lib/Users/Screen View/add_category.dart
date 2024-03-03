import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:recipe/Users/Screen%20View/category.dart';
import '../../api_connection/api_connection.dart';
import '../../round_button.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  addCategory() async{
    try{
      var res = await http.post(
        Uri.parse(API.addCategory),
        body: {
          'CATEGORY_NAME':nameController.text.trim(),
        },
      );
      if(res.statusCode ==200){
        var resBody = jsonDecode(res.body);
        if(resBody['success']==true){
          print('Added SuccessFully');
          Get.snackbar('Category', 'Added SuccessFully',
              backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
          setState(() {
            nameController.clear();
          });
          Get.to(const Catagory());
        }
        else{
          print('try again');
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
          body:LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Container(
                  width: constraints.maxWidth,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/bg.jpg'),fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    width: constraints.maxWidth,
                    color: Colors.white.withOpacity(0.7),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Add Category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            const SizedBox(
                              height: 40,
                            ),
                            Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      validator: (val) =>
                                      val == "" ? "please Enter Name" : null,
                                      keyboardType: TextInputType.emailAddress,
                                      autofillHints: const [AutofillHints.email],
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.person),
                                        hintText: 'Category Name',
                                        border: OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.circular(20)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.circular(20)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.circular(20)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide:
                                            const BorderSide(color: Colors.black),
                                            borderRadius: BorderRadius.circular(20)),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () {
                                      print('ok');
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)),
                                InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        addCategory();
                                      }
                                    },
                                    child: const RoundButton(
                                      inputText: 'Add',
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}

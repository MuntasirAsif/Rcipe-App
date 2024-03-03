import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../../round_button.dart';
import 'instructions.dart';

class Recipe extends StatefulWidget {
  final String catagoryName;
  const Recipe({super.key, required this.catagoryName});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  final nameController = TextEditingController();
  final dishNameController = TextEditingController();
  List<dynamic> recipe = [];
  getData() async {
    try {
      if (kDebugMode) {
        print('ok');
      }
      var res = await http.post(Uri.parse(API.recipe), body: {
        'CATAGORY_NAME': widget.catagoryName.toString(),
      });
      setState(() {
        recipe = jsonDecode(res.body)["userData"];
      });
      if (kDebugMode) {
        print(recipe);
      }
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  addItem() async {
    int first = Random().nextInt(10000);
    int second = Random().nextInt(10000);
    int third = Random().nextInt(10000);
    int fourth = Random().nextInt(10000);
    int fifth = Random().nextInt(10000);
    int mul = first + second + third + fourth + fifth;
    try {
      var res = await http.post(
        Uri.parse(API.addRecipe),
        body: {
          'RECIPE_ID': mul.toString(),
          'RECIPE_NAME': nameController.text.trim(),
          'DISH_NAME': dishNameController.text.toString(),
          'CATEGORY_NAME': widget.catagoryName.toString(),
        },
      );
      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if (resBody['success'] == true) {
          if (kDebugMode) {
            print('Added SuccessFully');
          }
          Get.snackbar('Item', 'Added SuccessFully',
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
          setState(() {
            nameController.clear();
            dishNameController.clear();
          });
          getData();
          Navigator.pop(context);
        } else {
          if (kDebugMode) {
            print('try again');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
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
                    color: Colors.white.withOpacity(0.4),
                    child: SizedBox(
                      height: 700,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.catagoryName} Items",
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: constraints.maxHeight-100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                  itemCount: recipe.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(Instructions(
                                          recipeId: recipe[index]['RECIPE_ID'],
                                          recipeName: recipe[index]['RECIPE_NAME'],
                                        ));
                                      },
                                      child: Card(
                                        color: Colors.green.shade100,
                                        child: ListTile(
                                          title: Text(recipe[index]['RECIPE_NAME']),
                                          subtitle: Text(recipe[index]['DISH_NAME']),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Get.defaultDialog(backgroundColor: Colors.green.shade100,
                                    title: 'Add Item',
                                    content: SizedBox(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            validator: (val) =>
                                            val == "" ? "please Enter Name" : null,
                                            keyboardType: TextInputType.emailAddress,
                                            autofillHints: const [AutofillHints.email],
                                            style: const TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(color: Colors.black),
                                              prefixIcon: const Icon(
                                                Icons.set_meal,
                                                color: Colors.black,
                                              ),
                                              hintText: 'Name',
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: dishNameController,
                                            validator: (val) =>
                                            val == "" ? "please Enter Name" : null,
                                            keyboardType: TextInputType.emailAddress,
                                            autofillHints: const [AutofillHints.email],
                                            style: const TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(color: Colors.black),
                                              prefixIcon: const Icon(
                                                Icons.set_meal,
                                                color: Colors.black,
                                              ),
                                              hintText: 'Dish Name',
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
                                      ),
                                    ),
                                    confirm: InkWell(
                                      onTap: () {
                                        addItem();
                                      },
                                      child: const SizedBox(
                                          height: 40,
                                          width: 80,
                                          child: RoundButton(
                                            inputText: 'Add',
                                          )),
                                    ),
                                    textCancel: 'Cancel');
                              },
                              child: const RoundButton(inputText: 'Add Items'))
                        ],
                      ),
                    )),
                  ),
                );
            },
          )
      ),
    );
  }
}

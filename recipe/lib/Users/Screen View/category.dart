import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe/Users/Screen View/add_category.dart';
import 'package:recipe/Users/Screen%20View/recipe.dart';
import 'package:recipe/round_button.dart';
import '../../api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
class Catagory extends StatefulWidget {
  const Catagory({super.key});

  @override
  State<Catagory> createState() => _CatagoryState();
}

class _CatagoryState extends State<Catagory> {
  List<dynamic> category=[];
  getData()async{
    try{
      var res = await http.post(
        Uri.parse(API.category),
      );
      setState(() {
        category=jsonDecode(res.body)["userData"];
      });
      if (kDebugMode) {
        print(category);
      }
    }catch(e){
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Food Category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: constraints.maxHeight-100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  ListView.builder(itemCount:category.length,itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  Get.to(Recipe(catagoryName: category[index]['CATEGORY_NAME'],));
                                },
                                child: Card(
                                  color: Colors.green.shade100,
                                  child: ListTile(
                                    title: Text(category[index]['CATEGORY_NAME']),
                                  ),
                                ),
                              );
                  
                            }),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(const AddCategory());
                          },
                            child: const RoundButton(inputText: 'Add Category'))
                      ],
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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../api_connection/api_connection.dart';
import '../../round_button.dart';

class Instructions extends StatefulWidget {
  final String recipeId;
  final String recipeName;
  const Instructions({super.key, required this.recipeId, required this.recipeName});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final descriptionController = TextEditingController();
  List<dynamic> instructions=[];
  getData()async{
    try{
      if (kDebugMode) {
        print(widget.recipeId);
      }
      var res = await http.post(
          Uri.parse(API.instructions),
          body: {
            'RECIPE_ID' : widget.recipeId.toString(),
          }
      );
      setState(() {
        instructions=jsonDecode(res.body)["userData"];
      });
      if (kDebugMode) {
        print(instructions);
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
  addDescription()async{
    try{
      var res = await http.post(
        Uri.parse(API.addInstruction),
        body: {
          'INSTRUCTION_ID': (instructions.length+1).toString(),
          'RECIPE_ID':widget.recipeId,
          'DESCRIPTION':descriptionController.text.trim(),
        },
      );
      if(res.statusCode ==200){
        var resBody = jsonDecode(res.body);
        if(resBody['success']==true){
          if (kDebugMode) {
            print('Added SuccessFully');
          }
          Get.snackbar('Instruction', 'Added SuccessFully',
              backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
          setState(() {
            descriptionController.clear();
          });
          getData();
          Navigator.pop(context);
        }
        else{
          if (kDebugMode) {
            print('try again');
          }
        }
      }
    }catch(e){
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
                          Text(widget.recipeName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: constraints.maxHeight-100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  ListView.builder(itemCount:instructions.length,itemBuilder: (context,index){
                                return Card(
                                  color: Colors.green.shade100,
                                  child: ListTile(
                                    title: Text('Recipe: ${instructions[index]['INSTRUCTION_ID']}'),
                                    subtitle: Text(instructions[index]['DESCRIPTION']),
                                  ),
                                );
                              }),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                    backgroundColor: Colors.green.shade100,
                                    title: 'Instructions',
                                    content: SizedBox(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: descriptionController,
                                            validator: (val) =>
                                            val == "" ? "please Enter Name" : null,
                                            keyboardType: TextInputType.multiline,
                                            autofillHints: const [AutofillHints.email],
                                            style: const TextStyle(color: Colors.black),
                                            minLines: 3,
                                            maxLines: 7,
                                            decoration: InputDecoration(
                                              hintText: 'Procedure',
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
                                        ],
                                      ),
                                    ),
                                    confirm: InkWell(
                                      onTap: (){
                                        addDescription();
                                      },
                                      child: const SizedBox(
                                          height: 40,
                                          width: 80,
                                          child: RoundButton(inputText: 'Add',)),),
                                    textCancel: 'Cancel');
                              },
                              child: const RoundButton(inputText: 'Add Procedure'))
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

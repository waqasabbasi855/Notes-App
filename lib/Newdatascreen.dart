import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/main.dart';

class newdata extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return newdat();
  }

}
class newdat extends State<newdata>
{
TextEditingController newdata=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Enter Data",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green.shade200),
    body: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(child: TextField(controller:newdata,decoration: InputDecoration(hintText: "Enter Data")),),
        ),
        SizedBox(height: 10,),
        ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green.shade200)),onPressed: (){
          if(newdata.text.isNotEmpty)
           { FirebaseFirestore.instance.collection("notes").add(
                {"note": "${newdata.text}"}).then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  },));
            });}
          }, child:Text("Save",style: TextStyle(color: Colors.white),))
      ],
    )
    );
  }


}
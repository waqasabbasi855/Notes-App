import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/main.dart';

class edit extends StatefulWidget{
  late String text;
  late String id;

  edit(this.text, this.id);

  @override
  State<edit> createState() => _editState(text,id);
}

class _editState extends State<edit> {
  late String edittext;
  _editState(this.edittext, this.editid);
  late String editid;
  TextEditingController editor=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(backgroundColor: Colors.green.shade200,title: Text("Edit Note",style: TextStyle(color: Colors.white),),),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [
          Container(child: TextField(controller: editor..text="${edittext}"),),
          SizedBox(height: 10,),
          ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green.shade200,)),onPressed: () async{
           await FirebaseFirestore.instance.collection("notes").doc("$editid").update({"note":"${editor.text}"});
Navigator.push(context, MaterialPageRoute(builder: (context) {
  return MyHomePage();
},));
          }, child: Text("Update",style: TextStyle(color: Colors.white),)),
        ],
      ),
    ),
    );
  }
}
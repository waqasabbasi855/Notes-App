import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/Editscreen.dart';
import 'package:notes/Newdatascreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey:"AIzaSyAVv1ptg3Vsqh59OgMqnk8Fbsh42OOFCDQ" , appId:"1:347073040034:android:8059ff55dacaf13c9d51fb" , messagingSenderId:"347073040034", projectId:"notesapp-6ebd0"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text("Notes",style: TextStyle(color: Colors.white),),
      centerTitle: true,),
      body: Stack(
        children: [
StreamBuilder(stream: FirebaseFirestore.instance.collection("notes")
    .where("note",isNotEqualTo:"").
snapshots(), builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
  return ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder:
      (context, index) {
    if(snapshot.hasError)
      {return Text("Error");}
    else if(snapshot.hasData==null){return Text("No Data Found");}
   else if(snapshot.hasData) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Container(color:Colors.green.shade200,child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return edit(snapshot.data!.docs[index]["note"], snapshot.data!.docs[index].id);
            },));
          },
          child: Card(shape:RoundedRectangleBorder(borderRadius:
          BorderRadius.all(Radius.zero)),color:
          Colors.white,child: Container(margin: EdgeInsets.only(left: 10),
            child: Stack(
              children:[
                Container(alignment: Alignment.bottomRight,child:
                IconButton(alignment: Alignment.topCenter,onPressed: (){
                  FirebaseFirestore.instance.collection("notes").doc(snapshot.data!.docs[index].id).delete();
                }, icon: Icon(Icons.delete,color: Colors.black,))),
                Column(
                children: [
                  SizedBox(height: 10,),
                  Container(alignment: Alignment.topLeft,
                    child: Text(snapshot.data
                        ?.docs[index]["note"],style: TextStyle(fontSize: 20),),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ],),
          )),
        ),),
      );
    }
    return Container();},
  );

},),
          Container(margin:EdgeInsets.only(bottom: 20,right: 40),alignment:
          Alignment.bottomRight,child:
          ElevatedButton(style: ButtonStyle(shape: MaterialStatePropertyAll(CircleBorder(side: BorderSide(width: 1))),backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return newdata();
            },));
              },
              child:Text("+",style: TextStyle(fontSize: 35,color: Colors.white),)),)
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

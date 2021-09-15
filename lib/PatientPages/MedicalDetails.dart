import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicalDetails extends StatefulWidget {
  @override
  _MedicalDetailsState createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  String _allergies, _diseases;
  getData() async{
    User user= FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Patient').doc(user.uid).get();
    setState(() {
      _allergies = snapshot['Allergies'];
      _diseases = snapshot['Chronic Diseases'];

    });
  }
  Widget boxInfo(var info){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(0.1),
              offset: Offset(-2.0, -2.0),
              blurRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(0.2),
              offset: Offset(2.0, 2.0),
              blurRadius: 2.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.2),style: BorderStyle.solid)
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(title: Text("$info",style: TextStyle(fontSize: 20.0,color: Colors.black.withOpacity(0.7),),)),
      ),
    );
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    while(_allergies==null){
      return Scaffold(
          backgroundColor: Colors.white,
          appBar:  AppBar(backgroundColor: Colors.white,elevation: 0,),
          body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ))
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(10.0)),
                Text("Medical Details",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,),),
                Padding(padding: const EdgeInsets.all(10.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Allergies",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_allergies),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Chronic Diseases",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_diseases),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  String _name,_email,_aadhar,_phone,_ec1,_ec2;
  getData() async{

    User user= FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Patient').doc(user.uid).get();
    setState(() {
      _name = snapshot['Name'];
      _aadhar = snapshot['Aadhar Number'];
      _phone = snapshot['Phone Number'];
      _email = snapshot['Email'];
      _ec1 = snapshot['Emergency Contacts'][0];
      _ec2 = snapshot['Emergency Contacts'][1];
    });
  }
  Widget boxInfo(var info){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
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
        padding: const EdgeInsets.all(11.0),
        child: Text("$info",style: TextStyle(fontSize: 20.0,color: Colors.black.withOpacity(0.7),),),
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

    while(_name==null){
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
                Text("Personal Details",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,),),
                Padding(padding: const EdgeInsets.all(10.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Name",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_name),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Aadhar Number",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_aadhar),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Phone Number",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_phone),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Email Id",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_email),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Emergency Contact 1",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_ec1),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Emergency Contact 2",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_ec2),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medic_app/HomePages/DoctorHome.dart';

class PrescriptionPage extends StatefulWidget {
  final String pid;
  PrescriptionPage(this.pid);
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState(pid);
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final String pid;
  _PrescriptionPageState(this.pid);
  final GlobalKey<FormState> _formKey1= GlobalKey<FormState>();
  String _disease,_pres,_remark,_name;
  void submit() async{
    _formKey1.currentState.save();
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot reference= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Doctor').doc(user.uid).get();
    _name=reference['Name'];
    await FirebaseFirestore.instance.collection('Consulting').add({
      'Patient Id': pid,
      'Doctor Name': _name,
      'Suspected Disease': _disease,
    'Prescription': _pres,
    'Remarks': _remark,
      'Date': DateTime.now(),
      'Finished': false,
      'Bought': false,
    });
    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => DoctorHomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text("Prescription",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Form(
                    key: _formKey1,
                    child:  new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          onSaved: (input) => _disease=input ,
                          decoration: InputDecoration(
                              labelText: 'Suspected Disease',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          maxLines: 5,
                          onSaved: (input) => _pres=input,
                          decoration: InputDecoration(
                            labelText: 'Prescriptions',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0)
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          maxLines: 5,
                          onSaved: (input) => _remark=input ,
                          decoration: InputDecoration(
                            labelText: 'Remarks',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0)
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        MaterialButton(
                          color: Colors.lightBlueAccent,
                          minWidth: 100.0,
                          elevation: 5.0,
                          child: Text("  Prescribe  ",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                          onPressed: (){
                            submit();
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
      ]
    ),
      )
    );
  }
}

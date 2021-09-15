import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_app/DoctorPages/PrescriptionPage.dart';

class PatientInfo extends StatefulWidget {
  final String pid;
  PatientInfo(this.pid);
  @override
  _PatientInfoState createState() => _PatientInfoState(pid);
}

class _PatientInfoState extends State<PatientInfo> {
  final String pid;
  _PatientInfoState(this.pid);
  String _name,_allergies,_diseases;
  DateTime _dob;
  int _age;
  getData() async{
    DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Patient').doc(pid).get();
    setState(() {
      _name = snapshot['Name'];
      _dob = snapshot['DOB'].toDate();
      _age = DateTime.now().difference(_dob).inDays;
      _age = _age~/365;
      _allergies = snapshot['Allergies'];
      _diseases = snapshot['Chronic Diseases'];
    });
  }
  Widget boxInfo(var info,var h){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: h,
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
        child:  Text("$info",style: TextStyle(fontSize: 20.0,color: Colors.black.withOpacity(0.7),),),
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
                Text("Patient Details",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,),),
                Padding(padding: const EdgeInsets.all(10.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Name",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_name,50.0),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Age",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_age,50.0),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Allergies",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_allergies,150.0),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Chronic Diseases",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_diseases,150.0),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                    child: Text("  Next  "),
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => PrescriptionPage(pid)));
                      }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

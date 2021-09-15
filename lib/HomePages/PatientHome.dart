import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medic_app/Authentication/Login.dart';
import 'package:medic_app/PatientPages/ConsultHistory.dart';
import 'package:medic_app/PatientPages/MedicalDetails.dart';
import 'package:medic_app/PatientPages/PersonalDetails.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}
class _PatientHomePageState extends State<PatientHomePage> {
  TextStyle _textStyle=TextStyle(fontSize: 20.0,color: Colors.black87);
  String userId,dId;
  getUser() async{
    setState(() {
      userId= FirebaseAuth.instance.currentUser.uid;
    });
  }
  updateInfo()async{
    await FirebaseFirestore.instance.collection('Consulting').doc(dId).update({
      'Finished': true
    });
  }
  Widget dosage(){
    return ListView(
      children: [
        Padding(padding: EdgeInsets.only(top:30.0)),
        Center(child: Text("Dosage",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,),)),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FutureBuilder(
              future: FirebaseFirestore.instance.collection("Consulting").where('Patient Id',isEqualTo: userId).where('Finished',isEqualTo: false)
                  .orderBy('Date',descending: true).get(),
              builder: (context,snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(),);
                }
                else {
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Column(
                        children: [
                          Container(child: SvgPicture.asset("Images/patient.svg"),height: 400,),
                          Center(child: Text("No Dosage available",style: TextStyle(fontSize: 20,color: Colors.black87),),)
                        ],
                      ),
                    );
                  }
                  else {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot pres = snapshot.data.documents[index];
                        return ListTile(
                          title: Text("Medicines: ${pres['Prescription']}"),
                          subtitle: Text("Remarks: ${pres['Remarks']}"),
                          isThreeLine: true,
                          trailing: Text("Long Press to Finish", style: TextStyle(color: Colors.redAccent),),
                          onLongPress: () {
                            setState(() {
                              dId=pres.id;
                            });
                            updateInfo();
                            PatientHomePage();
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    );
                  }
                }
              }
          ),
        ),
      ],
    );

  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    while(userId==null){
      return Scaffold(
          backgroundColor: Colors.white,
          appBar:  new AppBar(
            title: Text("THE MEDIC"),
            centerTitle: true,
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ))
      );
    }
    return Scaffold(
      appBar: new AppBar(
        title: Text("THE MEDIC"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: new Drawer(
        elevation: 10.0,
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ListTile(
              title: Text("Hello Patient",style: TextStyle(fontSize: 25.0,color: Colors.lightBlueAccent),),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ListTile(
              title: Text("Personal Details",style: _textStyle,),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => PersonalDetails()));
              },
            ),
            ListTile(
              title: Text("Medical Details",style: _textStyle,),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => MedicalDetails()));
              },
            ),
            ListTile(
              title: Text("Consult History",style: _textStyle,),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => ConsultHistory(userId)));
              },
            ),
            Divider(),
            ListTile(
              title: Text("Logout",style: _textStyle,),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
      ),
      body: dosage()
    );
  }
}

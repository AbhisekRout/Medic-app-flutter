import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_app/PatientPages/ConsultDetails.dart';

class ConsultHistory extends StatefulWidget {
  final String pId;
  ConsultHistory(this.pId);
  @override
  _ConsultHistoryState createState() => _ConsultHistoryState(pId);
}

class _ConsultHistoryState extends State<ConsultHistory> {
  final String pId;
  _ConsultHistoryState(this.pId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top:30.0)),
          Center(child: Text("Consult History",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,),)),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("Consulting").where('Patient Id',isEqualTo: pId).orderBy('Date',descending: true).get(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else {
                    if (snapshot.data.documents.length == 0) {
                      return Center(child: Text("No Prescriptions", style: TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.bold),));
                    }
                    else {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot pres = snapshot.data.documents[index];
                          return ListTile(
                            title: Text("Doctor: ${pres['Doctor Name']}"),
                            subtitle: Text("Consult Date: ${pres['Date'].toDate()}"),
                            isThreeLine: true,
                            trailing: Text("Status: ${pres['Bought']?'Bought':'New'}", style: TextStyle(color: pres['Bought']? Colors.redAccent : Colors.green),),
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => ConsultDetails(pres.id)));
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
      ),
    );
  }
}

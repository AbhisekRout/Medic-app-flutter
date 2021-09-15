import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medic_app/HomePages/PharmacistHome.dart';

class Prescription extends StatefulWidget {
  final String pId;
  Prescription(this.pId);
  @override
  _PrescriptionState createState() => _PrescriptionState(pId);
}

class _PrescriptionState extends State<Prescription> {
  final String pId;
  _PrescriptionState(this.pId);
  String _meds,_remarks;
  getData() async{
    DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('Consulting').doc(pId).get();
    setState(() {
      _meds = snapshot['Prescription'];
      _remarks = snapshot['Remarks'];
    });
  }
  updateInfo()async{
    await FirebaseFirestore.instance.collection('Consulting').doc(pId).update({
      'Bought': true
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
    while(_meds==null){
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
                Text("Prescription",style: TextStyle(fontSize: 30.0,color: Colors.lightBlueAccent,),),
                Padding(padding: const EdgeInsets.all(10.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Medicines",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_meds,150.0),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Align(alignment: Alignment(-0.95, 0),child: Text("Remarks",style: TextStyle(fontSize: 20.0,color: Colors.black54,),textAlign: TextAlign.left,),),
                boxInfo(_remarks,150.0),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Container(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                      child: Text("  Sold  "),
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      onPressed: (){
                        updateInfo();
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => PharmacistHomePage()));
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

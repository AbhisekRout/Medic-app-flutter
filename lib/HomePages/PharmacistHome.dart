import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medic_app/Authentication/Login.dart';
import 'package:medic_app/PharmaPages/PharmaInfo.dart';
import 'package:medic_app/PharmaPages/PrescriptionsPage.dart';

class PharmacistHomePage extends StatefulWidget {
  @override
  _PharmacistHomePageState createState() => _PharmacistHomePageState();
}

class _PharmacistHomePageState extends State<PharmacistHomePage> {
  TextStyle _textStyle=TextStyle(fontSize: 20.0,color: Colors.black87);
  String _scanData;
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanData = barcodeScanRes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("THE MEDIC"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: new Drawer(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ListTile(
              title: Text("Hello Pharmacist",style: TextStyle(fontSize: 25.0,color: Colors.lightBlueAccent),),
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            ListTile(
              title: Text("Account info",style: _textStyle,),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => PharmaInfo()));
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
      body: Center(
        child: SvgPicture.asset("Images/pharma.svg"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          scanQR();
          if(_scanData!=null){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => PrescriptionsPage(_scanData)));
          }
        } ,
        label: Text("Scan"),
        icon: Icon(Icons.settings_overscan),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}

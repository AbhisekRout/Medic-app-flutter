import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_app/Authentication/SignUp.dart';
import 'package:medic_app/HomePages/DoctorHome.dart';
import 'package:medic_app/HomePages/PatientHome.dart';
import 'package:medic_app/HomePages/PharmacistHome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color _color=Colors.lightBlueAccent;
  int selection=0;
  String _email,_password;
  TextStyle _selected=TextStyle(fontSize: 20.0,color: Colors.lightBlueAccent);
  TextStyle _notSelected=TextStyle(fontSize: 20.0,color: Colors.black54);
  Widget _widget;
  bool isHidden1=true;
  bool isHidden2=true;
  bool isHidden3=true;
  final GlobalKey<FormState> _formKey1= GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2= GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3= GlobalKey<FormState>();

  bool validPatient() {
    final form=_formKey1.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    else
      return false;
  }
  void submitPatient() async{
    if(validPatient()) {
      try {
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        DocumentSnapshot reference= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Patient').doc(user.uid).get();
        print(reference['Verified']);
        if(reference['Verified']==true)
        {
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => PatientHomePage()));
        }
        else
        {
          await FirebaseAuth.instance.signOut();
          Fluttertoast.showToast(
              msg: "Wait to get Verified!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black26,
              textColor: Colors.red,
              fontSize: 18.0
          );
        }

      }
      catch(e){
        Fluttertoast.showToast(
            msg: "Invalid Email or Password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black26,
            textColor: Colors.red,
            fontSize: 18.0
        );
      }
    }
  }
  bool validDoctor() {
    final form=_formKey2.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    else
      return false;
  }
  void submitDoctor() async{
    if(validDoctor()) {
      try {
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        DocumentSnapshot reference= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Doctor').doc(user.uid).get();
        if(reference['Verified']==true)
        {
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => DoctorHomePage()));
        }
        else
        {
          await FirebaseAuth.instance.signOut();
          Fluttertoast.showToast(
              msg: "Wait to get Verified!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black26,
              textColor: Colors.red,
              fontSize: 18.0
          );
        }

      }
      catch(e){
        Fluttertoast.showToast(
            msg: "Invalid Email or Password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black26,
            textColor: Colors.red,
            fontSize: 18.0
        );
      }
    }
  }
  bool validPharma() {
    final form=_formKey3.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    else
      return false;
  }
  void submitPharma() async{
    if(validPharma()) {
      try {
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        DocumentSnapshot reference= await FirebaseFirestore.instance.collection('Users').doc('oC9ieBhg2gWYztO9kDWA').collection('Pharma').doc(user.uid).get();
        print(reference['Verified']);
        if(reference['Verified']==true)
        {
          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => PharmacistHomePage()));
        }
        else
        {
          await FirebaseAuth.instance.signOut();
          Fluttertoast.showToast(
              msg: "Wait to get Verified!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black26,
              textColor: Colors.red,
              fontSize: 18.0
          );
        }

      }
      catch(e){
        Fluttertoast.showToast(
            msg: "Invalid Email or Password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black26,
            textColor: Colors.red,
            fontSize: 18.0
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget patient(){
      return Form(
        key: _formKey1,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(!input.contains('@')){
                  return "Enter valid Email Address!";
                }
                return null;
              },
              onSaved: (input) => _email=input ,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return "Password can't be Empty!";
                }
                return null;
              },
              obscureText: isHidden1?true:false,
              onSaved: (input) => _password=input ,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isHidden1=!isHidden1;
                      _widget=patient();
                    });
                  },
                  icon: isHidden1?Icon(Icons.visibility_off):Icon(Icons.visibility),
                ),
                labelText: 'Password',
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0)
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
                alignment: Alignment(1.0, 0.0),
                child: InkWell(
                  child: Text("Forgot Password?",style: TextStyle(fontSize: 15.0,color: _color)),
                  onTap: (){
                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => ForgotPass()));
                  },
                )
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            MaterialButton(
              color: _color,
              minWidth: 100.0,
              elevation: 5.0,
              child: Text("    Log In    ",style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onPressed: (){
                submitPatient();
              },
            ),
            //Padding(padding: EdgeInsets.only(top: 5.0)),

          ],
        ),
      );
    }
    Widget doctor(){
      return Form(
        key: _formKey2,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(!input.contains('@')){
                  return "Enter valid Email Address!";
                }
                return null;
              },
              onSaved: (input) => _email=input ,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return "Password can't be Empty!";
                }
                return null;
              },
              obscureText: isHidden2?true:false,
              onSaved: (input) => _password=input ,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isHidden2=!isHidden2;
                      _widget=doctor();
                    });
                  },
                  icon: isHidden2?Icon(Icons.visibility_off):Icon(Icons.visibility),
                ),
                labelText: 'Password',
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0)
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
                alignment: Alignment(1.0, 0.0),
                child: InkWell(
                  child: Text("Forgot Password?",style: TextStyle(fontSize: 15.0,color: _color)),
                  onTap: (){
                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => ForgotPass()));
                  },
                )
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            MaterialButton(
              color: _color,
              minWidth: 100.0,
              elevation: 5.0,
              child: Text("    Log In    ",style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onPressed: (){
                submitDoctor();
              },
            ),
            //Padding(padding: EdgeInsets.only(top: 5.0)),
          ],
        ),
      );
    }
    Widget pharmacist(){
      return Form(
        key: _formKey3,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(!input.contains('@')){
                  return "Enter valid Email Address!";
                }
                return null;
              },
              onSaved: (input) => _email=input ,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return "Password can't be Empty!";
                }
                return null;
              },
              obscureText: isHidden3?true:false,
              onSaved: (input) => _password=input ,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isHidden3=!isHidden3;
                      _widget=pharmacist();
                    });
                  },
                  icon: isHidden3?Icon(Icons.visibility_off):Icon(Icons.visibility),
                ),
                labelText: 'Password',
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0)
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Container(
                alignment: Alignment(1.0, 0.0),
                child: InkWell(
                  child: Text("Forgot Password?",style: TextStyle(fontSize: 15.0,color: _color)),
                  onTap: (){
                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => ForgotPass()));
                  },
                )
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            MaterialButton(
              color: _color,
              minWidth: 100.0,
              elevation: 5.0,
              child: Text("    Log In    ",style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onPressed: (){
                submitPharma();
              },
            ),
            //Padding(padding: EdgeInsets.only(top: 5.0)),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(child: Image.asset("Images/The medic logo.png"),
            width: 130.0,
            height: 130.0,
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            Container(
              height: MediaQuery.of(context).size.height-(MediaQuery.of(context).size.height/4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow:[
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -5.0),
                      blurRadius: 5.0
                  )
                ],
              ) ,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Login",style: TextStyle(fontSize: 30.0,color: _color,fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlineButton(
                            child: Text("  Patient  ",style: selection==0?_selected:_notSelected),
                            borderSide: BorderSide(color: _color),
                            onPressed: (){
                              setState(() {
                                selection=0;
                                _widget=patient();
                              });
                            }
                        ),
                        OutlineButton(
                            child: Text("  Doctor  ",style: selection==1?_selected:_notSelected,),
                            borderSide: BorderSide(color: _color),
                            onPressed: (){
                              setState(() {
                                selection=1;
                                _widget=doctor();
                              });
                            }
                        ),
                        OutlineButton(
                            child: Text("Pharmacist",style: selection==2?_selected:_notSelected,),
                            borderSide: BorderSide(color: _color),
                            onPressed: (){
                              setState(() {
                                selection=2;
                                _widget=pharmacist();
                              });
                            }
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    _widget==null?patient():_widget,
                    Padding(padding: EdgeInsets.only(top: 60.0)),
                    Text("New User?",style: TextStyle(fontSize: 18.0,color: _color),),
                    OutlineButton(
                      borderSide: BorderSide(color: _color),
                      child: Text("   Sign Up   ",style: TextStyle(fontSize: 20.0,color: _color)),
                      onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medic_app/Authentication/Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color _color=Colors.lightBlueAccent;
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  String _name,_email,_phone,_password,_ec1,_ec2,_aadhar,_allergies,_diseases,_license,_collection="Patient";
  List ec= new List(2);
  int _radioValue=-1;
  DateTime _dob;
  bool valid() {
    final form=_formKey.currentState;
    if(form.validate())
      return true;
    else
      return false;
  }

  void submit() async{
    if(valid()) {
      try {
        User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        _formKey.currentState.save();
        ec[0]=_ec1;
        ec[1]=_ec2;
        if(_collection=="Patient"){
          await FirebaseFirestore.instance.collection("Users").doc('oC9ieBhg2gWYztO9kDWA').collection("Patient").doc(user.uid).set({
            'Aadhar Number': _aadhar,
            'Email': _email,
            'Name' : _name,
            'Phone Number' : _phone,
            'DOB' : _dob,
            'Emergency Contacts' : ec,
            'Allergies' : _allergies,
            'Chronic Diseases' : _diseases
          });
        }
        else if(_collection=="Doctor"||_collection=="Pharma") {
          await FirebaseFirestore.instance.collection("Users").doc(
              'oC9ieBhg2gWYztO9kDWA').collection("Patient").doc(user.uid).set({
            'Aadhar Number': _aadhar,
            'Email': _email,
            'Name': _name,
            'Phone Number': _phone,
            'DOB': _dob,
            'Emergency Contacts': ec,
            'Allergies': _allergies,
            'Chronic Diseases': _diseases,
            'Verified': false
          });
          await FirebaseFirestore.instance.collection("Users").doc(
              'oC9ieBhg2gWYztO9kDWA').collection(_collection).doc(user.uid).set(
              {
                'License Number': _license,
                'Name': _name,
                'Verified': false
              });
        }
        Fluttertoast.showToast(
            msg: "Please wait to get verified then Login.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black26,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => LoginPage()));
      }
      catch(e){
        Fluttertoast.showToast(
            msg: "$e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black26,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }
  Widget _widget;
  @override
  Widget build(BuildContext context) {
    Widget license(){
      return Container(
        child: TextFormField(
          onSaved: (input) => _license=input ,
          decoration: InputDecoration(
              labelText: 'License Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0)
              )
          ),
        ),
      );
    }
    Widget others(){
      return SizedBox();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: Center(
        child: ListView(
          children: [
            Padding(padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(10.0)),
                Text("Sign Up",style: TextStyle(fontSize: 30.0,color: _color,fontWeight: FontWeight.bold),),
                Padding(padding: const EdgeInsets.all(10.0)),
                Text("Personal Details",style: TextStyle(fontSize: 20.0,color: Colors.black54,),),
                Form(
                  key:_formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Enter Full name!";
                          }
                          return null;
                        },
                        onSaved: (input) => _name=input ,
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Enter Full Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),

                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(!input.contains('@')){
                            return "Enter valid Email Address!";
                          }
                          return null;
                        },
                        onSaved: (input) => _email=input ,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Enter Aadhar Number!";
                          }
                          return null;
                        },
                        onSaved: (input) => _aadhar=input ,
                        decoration: InputDecoration(
                            labelText: 'Aadhar Number',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Enter Phone Number!";
                          }
                          return null;
                        },
                        onSaved: (input) => _phone=input ,
                        decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Enter Emergency Contact!";
                          }
                          return null;
                        },
                        onSaved: (input) => _ec1=input ,
                        decoration: InputDecoration(
                            labelText: 'Emergency Contact 1',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input.isEmpty){
                            return "Enter Emergency Contact!";
                          }
                          return null;
                        },
                        onSaved: (input) => _ec2=input ,
                        decoration: InputDecoration(
                            labelText: 'Emergency Contact 2',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      InputDatePickerFormField(
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        onDateSaved: (input) => _dob=input,
                        initialDate: DateTime.now(),
                        fieldLabelText: "Date of Birth",
                        errorInvalidText: "Enter valid date of birth",
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input.length<6){
                            return "Atleast 6 Characters Required!";
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        obscureText: true,
                        onSaved: (input) => _password=input ,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password must be atleast 6 characters',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        validator: (input){
                          if(input!=_password){
                            return "Password didn't Match";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Divider(color: Colors.black54,),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text("Medical Details",style: TextStyle(fontSize: 20.0,color: Colors.black54,),),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        onSaved: (input) => _allergies=input ,
                        decoration: InputDecoration(
                            labelText: 'Allergies(If Any)',
                            hintText: 'Enter All allergies with "," in between',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      TextFormField(
                        onSaved: (input) => _diseases=input ,
                        decoration: InputDecoration(
                            labelText: 'Chronic Diseases(If Any)',
                            hintText: 'Enter all with "," in between',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)
                            )
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text("You are?",style: TextStyle(fontSize: 20.0,color: Colors.black54,),),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (val){
                              setState(() {
                                _radioValue=val;
                                _collection="Doctor";
                                _widget=license();
                              });
                            },
                          ),
                          new Text(
                            'Doctor',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: (val){
                              setState(() {
                                _radioValue=val;
                                _collection="Pharma";
                                _widget=license();
                              });
                            },
                          ),
                          new Text(
                            'Pharmacist',
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          new Radio(
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: (val){
                              setState(() {
                                _radioValue=val;
                                _collection="Patient";
                                _widget=others();
                              });
                            },
                          ),
                          new Text(
                            'Others',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      _widget!=null?_widget:others(),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      MaterialButton(
                        color: _color,
                        minWidth: 100.0,
                        elevation: 5.0,
                        child: Text("    Sign Up    ",style: TextStyle(fontSize: 20.0,color: Colors.white),),
                        onPressed: (){
                          submit();
                        },
                      ),
                    ],
                  ) ,
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}

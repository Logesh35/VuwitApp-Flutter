import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vuwit_app_ios/vuwitapp_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CountryPicker/country_picker.dart';
//Firebase Phone Authentication Tutorial
//https://medium.com/flutter-community/firebase-phone-authentication-on-a-flutter-app-78104686efc5
class LoginHome extends StatefulWidget {
  LoginHome({Key key}) : super(key: key);

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  //final phoneNumController = TextEditingController();
  String phoneNumController;
  String _smsVerificationCode;
  SharedPreferences prefs;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String phoneCode = '+91';
  Country _selected = Country(
    asset: "assets/flags/in_flag.png",
    dialingCode: "91",
    isoCode: "IN",
    name: "India",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Enter your phone number"),
      ),
      body: Row(children: <Widget>[
                      CountryPicker(
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                            phoneCode = '+' + country.dialingCode;
                          });
                        },
                        selectedCountry: _selected,
                      ),
                      Padding(padding: EdgeInsets.all(14.5)),
                      //SizedBox(width: 16.0),
                      RaisedButton(
                          padding: const EdgeInsets.all(8.0),
                          //textColor: Colors.white,
                          //color: ,
                          onPressed: () {
                            setState(() {
                              //_currentStep += 1;
                            });
                          },
                          child: Text('Next')
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextField(
                                keyboardType: TextInputType.number,
                                //controller: phoneNumController,
                                onChanged: (text) {
                                  print("First text field: $text");
                                  phoneNumController = text;
                                },
                                decoration: InputDecoration(labelText: "Phone Number", prefixText: "+91", border: OutlineInputBorder()),
                              ),
                              FlatButton(
                                child: Text("Send code"),
                                onPressed: () => _verifyPhoneNumber(context),
                              ),
                            ],
                          ),
                    ]),
    );
  }
  
  /// will get an AuthCredential object that will help with logging into Firebase.
  _verificationComplete(AuthCredential authCredential, BuildContext context) {
    //prefs = await SharedPreferences.getInstance();
    print("_verificationComplete");
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
      handleSignIn(authCredential: authCredential,authResult: authResult);
    });
  }

  Future<Null> handleSignIn({AuthCredential authCredential, AuthResult authResult}) async{
    final snackBar = SnackBar(content: Text("Success!!! UUID is: " + authResult.user.uid));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      print("_verificationComplete"+"Success!!! UUID is: " + authResult.user.uid);

      Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => VuwitAppHome()));
  }

  _smsCodeSent(String verificationId, List<int> code) {
    print("_smsCodeSent verificationId ="+verificationId+"\n code"+code.toString());
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  _verificationFailed(AuthException authException, BuildContext context) {
    print("_verificationFailed "+"Exception!! message:" + authException.message.toString());
    final snackBar = SnackBar(content: Text("Exception!! message:" + authException.message.toString()));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    print("_codeAutoRetrievalTimeout verificationId = "+verificationId);
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  /// method to verify phone number and handle phone auth
  _verifyPhoneNumber(BuildContext context) async {
    print("_verifyPhoneNumber");
    String phoneNumber = "+91" + phoneNumController.toString();
    print(phoneNumber);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (authCredential) => _verificationComplete(authCredential, context),
        verificationFailed: (authException) => _verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
        // called when the SMS code is sent
        codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]));
  }
  
}

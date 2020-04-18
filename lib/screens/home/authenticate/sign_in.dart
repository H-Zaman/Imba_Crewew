import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constant.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formState = GlobalKey<FormState>();
  bool loading = false;

  //text field state value
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            letterSpacing: 1.5,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              //GOES TO REGISTER
              widget.toggleView();
            },
            label: Text('Register'),
            icon: Icon(Icons.person),
          )
        ],
        backgroundColor: Colors.brown[300],
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signin_bg.jpg'),
            fit: BoxFit.cover,
          )
        ),
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formState,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              //EMAIL FIELD
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Field empty' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              //PASSWORD FIELD
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length <6 ? 'Password must be 6+ char long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 10,),
              loading ? LoadingSpinKit() : RaisedButton(
                  onPressed: () async{
                    if(_formState.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.singInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Incorrect Email & Password';
                          loading = false;
                        });
                      }
                    }
                  },
              color: Colors.pinkAccent,
              child: Text(
                'SignIn',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              ),
              SizedBox(height: 20,),
              Text(
                error,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


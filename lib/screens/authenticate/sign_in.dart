import 'package:coffee/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  
  final Function? toggleView;
  SignIn({this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView!();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Enter Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.length < 8 ? 'Enter 8+ Charachter Password' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Sign In', style: TextStyle(color: Colors.blue)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.SignInUser(email, password);
                    if (result == null) {
                      setState(() => error = "could not sign in");
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text (error),
            ],
          ),
        ),
      ),
    );
  }
}
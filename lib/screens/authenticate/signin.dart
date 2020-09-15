import 'package:flutter/material.dart';
import 'package:ninja_brew/services/auth.dart';
import 'package:ninja_brew/shared/constants.dart';
import 'package:ninja_brew/shared/loading.dart';



class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth =AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;




  String email="";
  String password="";
  String error ="";
  @override
  Widget build(BuildContext context) {
    return loading? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();


            }, icon: Icon(Icons.person), label: Text('Register')),
        ],
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In To Brew Crew'),

      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal:50.0 ,vertical: 20.0),
        child: Form(
            key: _formKey,

            child:Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => (val.isEmpty)? 'Enter email' : null,

                onChanged: (val){
                  setState(() {
                    email=val;
                  });

                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val) => (val.length<6)? 'Password should contain atleast 6 characters' : null,

              obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[200],
                child: Text('Sign In',
                style: TextStyle(color:Colors.white)),
                onPressed: ()async{
                  if(_formKey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });
                    print('valid');
                    dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        loading=false;
                        error='Could not sign in ';
                      });

                    }

                  }


                }
                ,
              ),
              SizedBox(height: 12.0),
              Text(error,
                style: TextStyle(
                    color:Colors.red,fontSize: 14.0),
              ),


            ],
          )

        ),
      ),
    );
  }
}

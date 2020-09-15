import 'package:flutter/material.dart';
import 'package:ninja_brew/screens/authenticate/authenticate.dart';
import 'package:ninja_brew/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:ninja_brew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);
    print("===> $user");

    //return home or authenticate

    if(user==null){
      return(Authenticate());
    }
    else {
      return Home();
    }
  }
}

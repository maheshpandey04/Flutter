import 'package:blog/Authentication.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'HomePage.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementaion auth;
  MappingPage({
    this.auth,
});
  State<StatefulWidget> createState(){
    return _MappingPageState();
  }
}

enum AuthStatus{
  notSignedIn,
  signedIn,
}
class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus=AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId){
      setState(() {
        authStatus=firebaseUserId==null?AuthStatus.notSignedIn: AuthStatus.signedIn;
      });

    });
  }

  void _signedIn(){
    setState(() {
      authStatus=AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus=AuthStatus.notSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:
        return new Login(
        auth:widget.auth,
    onSignedIn:_signedIn
        );
    case AuthStatus.signedIn:
    return new HomePage(
    auth:widget.auth,
    onSignedOut:_signedOut,
    );
    }

    return null;
  }
}

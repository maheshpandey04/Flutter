import 'package:flutter/material.dart';
import 'Authentication.dart';
class Login extends StatefulWidget {
  Login({
    this.auth,
    this.onSignedIn,
});
  final AuthImplementaion auth;
  final VoidCallback onSignedIn;
  @override
  _LoginState createState() => _LoginState();
}
enum FormType{
  login,
  register
}

class _LoginState extends State<Login> {
  final formKey=new GlobalKey<FormState>();
  FormType _formType=FormType.login;
  String _email="";
  String _password="";
  bool validateAndSave() {
    final form=formKey.currentState;
    if(form.validate())
      {
        form.save();
        return true;
      }
    else{
      return false;
    }

  }
  void  validateAndSubmit() async{
    if(validateAndSave()){
      try{
        if(_formType==FormType.login){
          String userId=await widget.auth.SignIn(_email, _password);
          print("Login userid=0+"+userId);
        }else{
          String userId=await widget.auth.SignUp(_email, _password);
          print("Register userid=0+"+userId);

        }
        widget.onSignedIn();
      }catch(e){
        print("Error"+e.toString());

      }
    }

  }
  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.register;
    });
  }
  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType=FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Blog App"),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(
          key: formKey,
            child:
        new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:createInputs()+createButtons(),

        )),
      ),
    );
  }
  List<Widget> createInputs(){
    return
        [
          SizedBox(height: 10.0,),
          logo(),
          SizedBox(height: 20.0,),
          new TextFormField(
            decoration: new InputDecoration(labelText:'Email'),
            validator: (value){
              return value.isEmpty?'Email is required':null;
            },
            onSaved: (value){
              return _email=value;
            },
          ),
          SizedBox(height: 10.0,),
          new TextFormField(
            decoration: new InputDecoration(labelText:'Password' ),
            obscureText: true,
            validator: (value){
              return value.isEmpty?'Password  is required':null;
            },
            onSaved: (value){
              return _password=value;
            },
          ),
          SizedBox(height: 20.0,),

        ];
  }
  Widget logo(){
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/codmos.jpg'),
      ),
    );
  }
  List<Widget> createButtons(){
    if(_formType==FormType.login){
      return
        [
          new RaisedButton(
            child: new Text("Login",style: new TextStyle(fontSize: 14.0),),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: validateAndSubmit,
          ),
          new FlatButton(
            child: new Text("Not have an account,Create Account",style: new TextStyle(fontSize: 20.0),),
            textColor: Colors.red,
            onPressed:moveToRegister ,
          )

        ];
    }
    else{
      return
        [
          new RaisedButton(
            child: new Text("Create Account",style: new TextStyle(fontSize: 14.0),),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: validateAndSubmit,
          ),
          new FlatButton(
            child: new Text("Already have an account?Login",style: new TextStyle(fontSize: 20.0),),
            textColor: Colors.red,
            onPressed:moveToLogin ,
          )

        ];
    }

  }



}

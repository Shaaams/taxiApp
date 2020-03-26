import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxiapp/auth/clint_register_screen.dart';
import 'package:taxiapp/home.dart';
import 'package:taxiapp/util/shared_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email , _password ;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _formAutoValidation = false;
  bool _enabled =true;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Sign In'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 48, top: 48),
        child: Form(
          autovalidate: _formAutoValidation,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                enabled: _enabled,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Email Is Reqired';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                enabled: _enabled,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Password Is Required';
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  Flexible(child: Container()),
                  FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){},
                      child: Text('Forgot Password?',style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),)
                  ),
                ],
              ),
              _enabled ? _signInButton(context, 'Sign In') : loading(context),
              or(context),
              sharedButton(context, 'Sign Up', ClintRegisterScreen()),

            ],
          ),
        ),
      ),
    );
  }

 Widget _signInButton(BuildContext context, String title) {
   return Container(
     height: 50,
     width: double.infinity,
     child: FlatButton(
       child: Text(
         title,
         style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
           letterSpacing: 1.5,
         ),
       ),
       onPressed: () {
          if(!_formKey.currentState.validate()){
            setState(() {
              _formAutoValidation = true;
            });
          }else{
            //ToDo: Make A Call
            _createUserLogin();

          }
       },
       color: Theme.of(context).primaryColorLight,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(25)),
       ),
     ),
   );
 }

 void _enableSubmitLogin(){
    setState(() {
      _enabled = false;
    });
 }

 void _setLoginDetails(){
    setState(() {
      _email = _emailController.text;
      _password = _passwordController.text;
    });
 }

 void _createUserLogin(){
    _enableSubmitLogin();
    _setLoginDetails();
    //ToDo: Make Call Firebase To Login User
   Future.delayed(Duration(seconds: 5), (){
     setState(() {
       _enabled = true;
     });
   });

 }

}

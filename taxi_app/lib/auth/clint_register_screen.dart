import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiapp/auth/driver_register_screen.dart';
import 'package:taxiapp/auth/login_screen.dart';
import 'package:taxiapp/util/shared_widgets.dart';

class ClintRegisterScreen extends StatefulWidget {
  @override
  _ClintRegisterScreenState createState() => _ClintRegisterScreenState();
}

class _ClintRegisterScreenState extends State<ClintRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _passwordConfirm;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  bool _formAutoValidation =false;
  bool enabled = true;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setBool('seen', true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Sign Up'),

      body: Form(
        autovalidate: _formAutoValidation,
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                enabled: enabled,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Email Is Required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                enabled: enabled,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Password Is Required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordConfirmController,
                enabled: enabled,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Confirm Password Is Required';
                  }
                  if (_passwordController.text != value ){
                    return 'Password Dos\'t Match !';
                  }
                  return null;
                },
              ),

              enabled ? _signUpButton(context, 'Sign Up'): loading(context),
              memberSignInLine(context, LoginScreen()),
              or(context),
              sharedButton(context, 'Create Driver Account', DriverRegisterScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpButton(BuildContext context, String title) {
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
            // Check Form State
          if(! _formKey.currentState.validate()){
            setState(() {
              _formAutoValidation = true;
            });
          }else{
            // ToDo: Make A Call
            _createUserAccount();
          }
        },
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }

  void _enableSubmitAccount(){
    setState(() {
      enabled = false;
    });
  }

  void _setClintAccount(){
    setState(() {
      _email    = _emailController.text;
      _password = _passwordController.text;
    });
  }

  void _createUserAccount(){
    _enableSubmitAccount();
    _setClintAccount();
    //ToDo: Mack Call FireBase To Create User Account

    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        enabled = true;
      });
    });
  }

 

}

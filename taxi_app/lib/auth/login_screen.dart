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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
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
              sharedButton(context, 'Sign In', HomeScreen()),
              or(context),
              sharedButton(context, 'Sign Up', ClintRegisterScreen()),

            ],
          ),
        ),
      ),
    );
  }

}

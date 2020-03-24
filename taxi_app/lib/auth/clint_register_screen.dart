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
  String email;
  String password;
  String passwordConfirm;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

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
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 75,
              ),
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
              sharedButton(context, 'Sign Up',LoginScreen()),
              _memberSignInLine(context),
              or(context),
              sharedButton(context, 'Create Driver Account', DriverRegisterScreen()),
            ],
          ),
        ),
      ),
    );
  }
  Widget _memberSignInLine(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('already member ?',
        style: TextStyle(
          color: Colors.grey,
        ),
        ),
        FlatButton(
          child: Text(
            'Sign In',
            style: TextStyle(color: Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginScreen()
            ));
          },
        ),
      ],
    );
  }
}

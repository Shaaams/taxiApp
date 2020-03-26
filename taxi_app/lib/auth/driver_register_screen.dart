import 'package:flutter/material.dart';
import 'package:taxiapp/util/shared_widgets.dart';

import 'login_screen.dart';
class DriverRegisterScreen extends StatefulWidget {
  @override
  _DriverRegisterScreenState createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _manufacturer;
  String _carModel;
  String _carYear;

  TextEditingController _emailController =TextEditingController();
  TextEditingController _passwordController =TextEditingController();
  TextEditingController _passwordConfirmController =TextEditingController();
  TextEditingController _manufacturerController =TextEditingController();
  TextEditingController _carModelController =TextEditingController();
  TextEditingController _carYearController =TextEditingController();

  PageController _pageController = PageController();
  bool _formAutoValidation = false;
  bool enabled = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _manufacturerController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          autovalidate: _formAutoValidation,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Flexible(
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    _userNamePage(context),
                    _carDetails(context),
                  ],
                ),
              ),
              Row(
                children: <Widget>[

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userNamePage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 75,
        ),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
          validator: _emailValidate,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
          ),
          obscureText: true,
          validator: _passValidate,
        ),
        TextFormField(
          controller: _passwordConfirmController,
          decoration: InputDecoration(
            hintText: 'Confirm Password',
          ),
          obscureText: true,
          validator:_passConfirmValidate,
        ),
        _nextButton(context, 'Next'),
        memberSignInLine(context, LoginScreen()),
      ],
    );
  }

  Widget _carDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 75,
        ),
        TextFormField(
          controller: _manufacturerController,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: 'Car Manufacturer',
          ),
          validator: _manufacturerValidate,
        ),
        TextFormField(
          controller: _carModelController,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: 'Car Model',
          ),
          validator: _carModelValidate,
        ),
        TextFormField(
          controller: _carYearController,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: 'Car Year',
          ),
          validator: _carYearValidate,
        ),
        enabled ? _doubleButton(context, 'BACK', 'SUBMIT') : loading(context),
        memberSignInLine(context, LoginScreen()),
      ],
    );
  }

  Widget _nextButton(BuildContext context , String title){
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
        onPressed: _nameButtonValidate,
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }

  Widget _doubleButton (BuildContext context, String titleOne, String titleTow){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: FlatButton(
            child: Text(
              titleOne,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            onPressed: () {
              // Go To Back
              _previousPage();
            },
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
        Flexible(
          child: FlatButton(
            child: Text(
              titleTow,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            onPressed: () {
              _carButtonValidate();
            },
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
        ),
      ],
    );
  }

  void _goNextPage(){
    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  void _previousPage(){
    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  String _emailValidate (String value){
    if (value.isEmpty){
      return 'Email Is Required';
    }
    return null;
  }

  String _passValidate(String value){
    if (value.isEmpty){
      return 'Password Is Required';
    }
    return null;
  }

  String _passConfirmValidate(String value){
    if (value.isEmpty){
      return 'Confirm Password Is Required';
    }
    if (_passwordController.text != value){
      return 'Your Password Dos\'t Match !';
    }
    return null;
  }

  void _nameButtonValidate(){
    // Check Form State
      if(!_formKey.currentState.validate()){
        setState(() {
          _formAutoValidation =true;
        });
      }else{
        // Save Data
        _setAccountDetails();
        // Move To Next Page
        _goNextPage();
      }
  }



  String _manufacturerValidate(String value) {
    if (value.isEmpty){
      return 'Manufacturer Is Required';
    }
    return null;
  }

  String _carModelValidate(String value) {
  if(value.isEmpty){
    return 'Car Model Is Required';
  }
  return null;
  }

  String _carYearValidate(String value) {
    if(value.isEmpty){
      return 'Car Year Is Required';
    }
    return null;
  }

  void _setAccountDetails(){
    setState(() {
      _email     = _emailController.text;
      _password  = _passwordController.text;
    });
  }

  void _setCarDetails(){
   setState(() {
     _manufacturer = _manufacturerController.text;
     _carModel     = _carModelController.text;
     _carModel     = _carModelController.text;
   });
  }
  void _carButtonValidate(){
    // Check Car Details are Filled
    if(! _formKey.currentState.validate()){
      setState(() {
        _formAutoValidation = true;
      });
    }else{
      
      //ToDo: Make A Call
      _createAccountDriver();

    }
  }
  void _enableSubmitAccount(){
    setState(() {
      enabled = false;
    });
  }

  void _createAccountDriver(){
    _enableSubmitAccount();
    _setCarDetails();
  //ToDo: Call Firebase To Create Driver Account

    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        enabled = true;
      });
    });
  }
}

import 'package:flutter/material.dart';
class ClintRegisterScreen extends StatefulWidget {
  @override
  _ClintRegisterScreenState createState() => _ClintRegisterScreenState();
}

class _ClintRegisterScreenState extends State<ClintRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Text('Clint Screen'),
      ),
    );
  }
}

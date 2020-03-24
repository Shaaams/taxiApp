import 'package:flutter/material.dart';
Widget appBar (BuildContext context, String title){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(title , style: Theme.of(context).textTheme.title),
  );
}

Widget or(BuildContext context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(child: divider(context)),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Text(
          'OR',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      Flexible(child: divider(context)),
    ],
  );

}

Widget divider(BuildContext context){
  return Container(
    height: 1,
    color: Colors.grey.shade300,
  );
}

Widget sharedButton(BuildContext context , String title , Widget screen){
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => screen,
        ));
      },
      color: Theme.of(context).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    ),
  );
}
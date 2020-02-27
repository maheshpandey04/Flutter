import 'package:blog/Mapping.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';

import 'Login.dart';

void main() {
  runApp(new BlogApp());
}
class BlogApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Blog App",
      theme: new ThemeData(
        primarySwatch: Colors.pink ,

      ),
      home: MappingPage(auth:Auth(),),
    );
  }

}
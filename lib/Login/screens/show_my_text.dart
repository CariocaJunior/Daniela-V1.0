import 'package:flutter/material.dart';

class ShowMyText extends StatelessWidget {
  final String text;
  ShowMyText(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Show My Text")),
        body: Center(child: Text(this.text)));
  }
}

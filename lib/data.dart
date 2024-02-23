import 'package:flutter/material.dart';

abstract class ListItems {

   buildTitle(BuildContext context);

   buildSubtitle(BuildContext context);
}


class Heading implements ListItems{
  String heading;

  Heading({required this.heading});
  @override
  buildTitle(BuildContext context) {
    return Text(heading,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),);
  }

  @override
  buildSubtitle(BuildContext context) {
    return const SizedBox.shrink();
  }
}


class Message implements ListItems{
  String sender,body;

  Message({required this.sender,required this.body});
  @override
  buildTitle(BuildContext context) {
    return Text(sender);
  }

  @override
  buildSubtitle(BuildContext context) {
    return Text(body);
  }
}
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, override_on_non_overriding_member

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  CustomAppBar({ required this.title }) : preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      backgroundColor: Color(0xFF233C5C),
    );
  }
}
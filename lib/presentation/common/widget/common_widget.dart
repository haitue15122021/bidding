import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color bgColor=Colors.white, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}



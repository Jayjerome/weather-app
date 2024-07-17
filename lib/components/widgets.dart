import 'package:flutter/material.dart';
import 'package:renmoney/utils/color_palette.dart';

Text buildText(String text,
    {Color color = Colors.black,
      double fontSize = 12,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.start,
      int? maxLines,
      TextOverflow overflow = TextOverflow.clip}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget weatherInfo(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      buildText("$title :", color: kBlackColor, fontWeight: FontWeight.w500, fontSize: 16),
      buildText(description, color: kBlackColor, fontWeight: FontWeight.w400, fontSize: 14),
    ],
  );
}
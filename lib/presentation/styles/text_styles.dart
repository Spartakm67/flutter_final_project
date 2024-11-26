import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {

  static const TextStyle appBarText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle spanKeyText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black,
  );

  static final TextStyle habitKeyText = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  static const TextStyle spanPostText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black,
  );

  static const TextStyle spanBodyText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: Colors.blueGrey,
  );

  static const TextStyle spanTitleText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.indigo,
  );

  static const TextStyle spanEmailText = TextStyle(
    fontSize: 12,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    color: Colors.indigo,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        offset: Offset(3.0, 3.0),
        blurRadius: 5.0,
        color: Colors.black26,
      ),
    ],
  );

  static final ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.indigo,
    backgroundColor: Colors.white70,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    textStyle: TextStyles.buttonText,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static const TextStyle defaultText = TextStyle(
    fontSize: 20,
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle greetingsText = TextStyle(
    fontSize: 30,
    color: Colors.redAccent,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle userText = TextStyle(
    fontSize: 14,
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static Text styledText(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}



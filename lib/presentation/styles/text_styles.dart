import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static const TextStyle appBarText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle numberText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );

  static final greetingsText = GoogleFonts.roboto(
    fontSize: 26,
    color: Colors.deepOrange,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle authWelcomeText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  static const TextStyle authText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle hintText = TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  static const TextStyle cartText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 16,
    decoration: TextDecoration.none,
  );

  static final TextStyle cartBottomText = GoogleFonts.openSans(
    color: Colors.blueGrey,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle oderAppBarText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    decoration: TextDecoration.none,
  );

  static const TextStyle spanKeyText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.grey,
  );

  static final TextStyle habitKeyText = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
    decoration: TextDecoration.none,
  );

  static const TextStyle spanPostText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black,
    decoration: TextDecoration.none,
  );

  static const TextStyle spanBodyText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: Colors.blueGrey,
    decoration: TextDecoration.none,
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

  static const TextStyle homeButtonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.black87,
  );

  static const TextStyle categoriesText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: Color(0xFF52545C),
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

  static TextStyle authIconStyle(Color color) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }
}

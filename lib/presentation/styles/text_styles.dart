import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_final_project/main.dart';

const double smallScreenWidth = 400;
const double screenMultiplier = 0.8;

class TextStyles {
  static final appBarText = TextStyle(

    fontSize: screenWidth >= smallScreenWidth ? 22 : (22 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle numberText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 22 : (22 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );

  static final greetingsText = GoogleFonts.roboto(
    fontSize: screenWidth >= smallScreenWidth ? 26 : (26 * screenMultiplier),
    color: Colors.deepOrange,
    fontWeight: FontWeight.bold,
  );

  static final authWelcomeText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 18 : (18 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  static final authText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 18 : (20 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final hintText = TextStyle(
    color: Colors.grey,
    fontSize: screenWidth >= smallScreenWidth ? 16 : (16 * screenMultiplier),
  );

  static final cartText = TextStyle(
    color: Colors.blueGrey,
    fontSize: screenWidth >= smallScreenWidth ? 16 : (16 * screenMultiplier),
    decoration: TextDecoration.none,
  );

  static final TextStyle cartBottomText = GoogleFonts.openSans(
    color: Colors.blueGrey,
    fontSize: screenWidth >= smallScreenWidth ? 20 : (20 * screenMultiplier),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static final TextStyle cartBarText = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: screenWidth >= smallScreenWidth ? 20 : (20 * screenMultiplier),
    fontWeight: FontWeight.bold,
  );

  static final TextStyle cartBarBtnText = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: screenWidth >= smallScreenWidth ? 20 : (20 * screenMultiplier),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle cartBarThinText = GoogleFonts.openSans(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: screenWidth >= smallScreenWidth ? 18 : (18 * screenMultiplier),
   );

  static final TextStyle oderAppBarText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 22 : (22 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    decoration: TextDecoration.none,
  );

  static final spanKeyText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: screenWidth >= smallScreenWidth ? 16 : (16 * screenMultiplier),
    color: Colors.grey,
  );

  static final TextStyle habitKeyText = GoogleFonts.roboto(
    fontSize: screenWidth >= smallScreenWidth ? 18 : (18 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
    decoration: TextDecoration.none,
  );

  static final TextStyle alertKeyText = GoogleFonts.roboto(
    fontSize: screenWidth >= smallScreenWidth ? 22 : (22 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: Colors.redAccent,
    decoration: TextDecoration.none,
  );

  static final spanPostText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: screenWidth >= smallScreenWidth ? 12 : (12 * screenMultiplier),
    color: Colors.black,
    decoration: TextDecoration.none,
  );

  static final TextStyle spanBodyText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: screenWidth >= smallScreenWidth ? 12 : (12 * screenMultiplier),
    color: Colors.blueGrey,
    decoration: TextDecoration.none,
  );

  static final TextStyle spanTitleText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: screenWidth >= smallScreenWidth ? 16 : (16 * screenMultiplier),
    color: Colors.indigo,
  );

  static final TextStyle spanEmailText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 12 : (12 * screenMultiplier),
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  static final TextStyle homeButtonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: screenWidth >= smallScreenWidth ? 18 : (18 * screenMultiplier),
    color: Colors.black87,
  );

  static final TextStyle categoriesText = GoogleFonts.roboto(
    fontSize: screenWidth >= smallScreenWidth ? 22 : (22 * screenMultiplier),
    fontWeight: FontWeight.bold,
    color: const Color(0xFF52545C),
    decoration: TextDecoration.none,
  );


  static final TextStyle buttonText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 18 : (18 * screenMultiplier),
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

  static final TextStyle defaultText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 20 : (20 * screenMultiplier),
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
  );

  static final TextStyle userText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 14 : (14 * screenMultiplier),
    color: Colors.blueAccent,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle ingredientsText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 16 : (14 * screenMultiplier),
    color: Colors.black87,
    // fontStyle: FontStyle.italic,
    // fontWeight: FontWeight.bold,
  );

  static final TextStyle ingredientPriceText = TextStyle(
    fontSize: screenWidth >= smallScreenWidth ? 14 : (14 * screenMultiplier),
    color: Colors.blueAccent,
    // fontStyle: FontStyle.italic,
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
      fontSize: screenWidth >= smallScreenWidth ? 28 : (28 * screenMultiplier),
      fontWeight: FontWeight.normal,
      color: color,
    );
  }
}







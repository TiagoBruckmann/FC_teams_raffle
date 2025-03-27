// import dos domains
import 'dart:math';

class SharedServices {

  String convertDate( int value ) {

    String converted = value.toString();
    if ( value < 10 ) {
      converted = "0$value";
    }

    return converted;
  }

  String getRandomString( int length ) {
    const chars = '1234567890';
    final Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }

}
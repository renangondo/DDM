import 'dart:math';

String stringGenerator() {
  const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      20, 
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
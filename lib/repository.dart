import 'package:english_words/english_words.dart';

class ParPalavra {
  String first;
  ParPalavra(this.first);
}

class ParPalavraRepository {}

ParPalavraRepository rep = ParPalavraRepository();
List palavraConstrutor() {
  var result = [];
  for (var i = 0; i < 20; i++) {
    WordPair wp = WordPair.random();
    ParPalavra p = ParPalavra(wp.first);
    result.add(p);
  }
  return result;
}

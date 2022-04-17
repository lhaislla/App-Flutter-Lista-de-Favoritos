import 'package:english_words/english_words.dart';

class ParPalavra {
  String first = '';
  ParPalavra(this.first);
  factory ParPalavra.constructor() {
    WordPair wp = generateWordPairs().first;
    ParPalavra p = ParPalavra(wp.first);
    return p;
  }
  String creat() {
    return first[0] + first.substring(1);
  }

  late final asPascalCase = creat();
}

class ParPalavraRepository {
  final _suggestions = <ParPalavra>[];
  ParPalavraRepository() {
    criaParPalavra(20);
  }
  void criaParPalavra(int num) {
    for (int i = 0; i < num; i++) {
      _suggestions.add(ParPalavra.constructor());
    }
  }

  ParPalavra getIndex(int index) {
    return _suggestions[index];
  }

  List getAll() {
    return _suggestions;
  }

  void addPalavra(ParPalavra wp, int index) {
    _suggestions.add(_suggestions[index]);
  }

  void removePalavra(ParPalavra wp) {
    _suggestions.removeAt(_suggestions.indexOf(wp));
  }
}

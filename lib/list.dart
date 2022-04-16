import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = <WordPair>{};
  bool statusBotao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de palavras'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Salvar Sugestões',
          ),
          IconButton(
            onPressed: (() {
              if (statusBotao == false) {
                statusBotao = true;
              } else if (statusBotao == true) {
                statusBotao = false;
              }
            }),
            tooltip: statusBotao ? 'List' : 'Card',
            icon: const Icon(Icons.apps_outlined),
          ),
        ],
      ),
      body: _buildSuggestions(statusBotao),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(pair.asPascalCase, style: _biggerFont),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Salvando Sugestões'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions(bool statusBotao) {
    if (statusBotao == false) {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index], index);
        },
      );
    } else {
      return _addContainer();
    }
  }

  Widget _buildRow(WordPair pair, int index) {
    final alreadySaved = _saved.contains(_suggestions[index]);
    final item = pair.asPascalCase;
    return Dismissible(
        key: Key(item),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          setState(() {
            if (alreadySaved) {
              _saved.remove(_suggestions[index]);
            }
            _suggestions.removeAt(index);
          });
        },
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          // ignore: prefer_const_constructors
          child: Text(
            "Excluir",
            // ignore: prefer_const_constructors
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        child: ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/Edit',
                arguments: _suggestions[index]);
          },
          trailing: IconButton(
              icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save'),
              tooltip: "Favorite",
              hoverColor: Colors.red,
              onPressed: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(_suggestions[index]);
                  } else {
                    _saved.add(_suggestions[index]);
                    debugPrint(_suggestions[index].first);
                    debugPrint(_suggestions[index].second);
                  }
                });
              }),
        ));
  }

  Widget _addContainer() {
    return GridView.builder(
        shrinkWrap: statusBotao,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(20));
          }
          return Container(
            child: Center(child: (_buildRow(_suggestions[index], index))),
            color: Colors.white30,
          );
        });
  }
}

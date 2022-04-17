import 'package:app_favorito_dsi/repository.dart';
import 'package:flutter/material.dart';

ParPalavraRepository repositoryParPalavra = ParPalavraRepository();

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <ParPalavra>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<ParPalavra> _saved = <ParPalavra>{};
  bool statusBotao = false;
  bool editMode = false;

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
            tooltip: statusBotao ? 'Lista' : 'Card',
            icon: const Icon(Icons.apps_outlined),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Adicionar nova palavra',
            onPressed: () {
              editMode = true;
              setState(() {
                Navigator.popAndPushNamed(context, '/edit', arguments: {
                  'parPalavra': repositoryParPalavra.getAll(),
                  'palavra': editMode
                });
              });
            },
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
              title: const Text('Favoritos Salvos'),
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
          if (index >= repositoryParPalavra.getAll().length) {
            repositoryParPalavra.criaParPalavra(10);
          }
          return _buildRow((repositoryParPalavra.getIndex(index)));
        },
      );
    } else {
      return _addContainer();
    }
  }

  Widget _buildRow(ParPalavra pair) {
    final alreadySaved = _saved.contains(pair);
    return Dismissible(
        key: Key(pair.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            }
            repositoryParPalavra.removePalavra(pair);
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
              pair.asPascalCase,
              style: _biggerFont,
            ),
            trailing: IconButton(
                icon: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null,
                    semanticLabel: alreadySaved ? 'Remover' : 'Salvar'),
                tooltip: "Favoritar",
                hoverColor: Colors.red,
                onPressed: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(pair);
                    } else {
                      _saved.add(pair);
                    }
                  });
                }),
            onTap: () {
              setState(() {
                Navigator.popAndPushNamed(context, '/edit', arguments: {
                  'parPalavra': repositoryParPalavra.getAll(),
                  'palavra': pair,
                });
              });
            }));
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
        itemBuilder: (context, index) {
          if (index >= repositoryParPalavra.getAll().length) {
            repositoryParPalavra.criaParPalavra(10);
          }
          return Container(
            child: Center(
                child: (_buildRow(repositoryParPalavra.getIndex(index)))),
            color: Colors.white30,
          );
        });
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  RandomWordsState createState() => RandomWordsState();
}

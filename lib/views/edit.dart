import 'package:app_favorito_dsi/repositories/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Editar extends StatefulWidget {
  static const routeName = '/edit';
  const Editar({Key? key}) : super(key: key);
  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Palavra'),
        ),
        body: Center(
          child: _adicionaPalavras(),
        ));
  }
}

class _adicionaPalavras extends StatefulWidget {
  @override
  State<_adicionaPalavras> createState() => _adicionaPalavrasState();
}

class _adicionaPalavrasState extends State<_adicionaPalavras> {
  @override
  Widget build(BuildContext context) {
    final temp = (ModalRoute.of(context)?.settings.arguments ??
        <List, ParPalavra>{}) as Map;
    var palavra = temp['palavra'];
    List<ParPalavra> parPalavra;
    parPalavra = temp['parPalavra'];
    final TextEditingController palavraum = TextEditingController();
    return Center(
        child: Column(
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        Center(
          child: Card(
            elevation: 30,
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Insira a palavra",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.red,
                      )),
                    ),
                    controller: palavraum),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            fixedSize: const Size(100, 40)),
                        onPressed: () {
                          setState(() {
                            if (palavra == true) {
                              parPalavra.insert(0, ParPalavra(palavraum.text));
                              palavra == false;
                            } else {
                              if (palavra == null) {
                                palavra == false;
                              } else {
                                parPalavra[parPalavra.indexOf(palavra)] =
                                    ParPalavra(palavraum.text);
                                palavra == false;
                              }
                              palavra == false;
                            }
                          });
                          Navigator.popAndPushNamed(context, '/');
                        },
                        child: const Text(
                          'Enviar',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ),
              ],
            )),
          ),
        )
      ],
    ));
  }
}

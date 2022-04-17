import 'package:app_favorito_dsi/repository.dart';
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
    final temp = (ModalRoute.of(context)?.settings.arguments ??
        <List, ParPalavra>{}) as Map;
    var palavra = temp['palavra'];
    List<ParPalavra> parPalavra;
    parPalavra = temp['parPalavra'];
    final TextEditingController palavraUm = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Palavra'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(hintText: "Insira apalavra"),
                  controller: palavraUm),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red, fixedSize: const Size(100, 40)),
                      onPressed: () {
                        setState(() {
                          if (palavra == true) {
                            parPalavra.insert(0, ParPalavra(palavraUm.text));
                            palavra == false;
                          } else {
                            if (palavra == null) {
                              palavra == false;
                            } else {
                              parPalavra[parPalavra.indexOf(palavra)] =
                                  ParPalavra(palavraUm.text);
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
        ));
  }
}

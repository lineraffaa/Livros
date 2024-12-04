import 'package:biblioteca/helpers/livro_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class LivroPage extends StatefulWidget {
  final Livro? livro;
  LivroPage({this.livro});

  @override
  State<LivroPage> createState() => _LivroPageState();
}

class _LivroPageState extends State<LivroPage> {
  Livro? _editLivro;
  bool _userEdit = false;

  List<String> list = <String>["Terror", "Drama", "Romance", "Fantasia"];
  late String dropdownvalue = list.first;

  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _anopubliController = TextEditingController();
  final _generoControler = TextEditingController();
  final _editoraControler = TextEditingController();

  final _tituloFocus = FocusNode();
  final _autorFocus = FocusNode();
  final _generoFocus = FocusNode();
  final _anopubliFocus = FocusNode();
  final _editoraFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.livro == null) {
      _editLivro = Livro();
    } else {
      _editLivro = Livro.fromMap(widget.livro!.toMap());
      _tituloController.text = _editLivro!.titulo;
      _autorController.text = _editLivro!.autor;
      _anopubliController.text = _editLivro!.anopubli;
      _generoControler.text = _editLivro!.genero;
      _editoraControler.text = _editLivro!.editora;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 245, 245),
                  Color.fromARGB(255, 126, 124, 124),
                ], // Gradiente de cores
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(_editLivro!.titulo ?? "Novo Livro"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editLivro!.titulo != null &&
                _editLivro!.titulo.isNotEmpty &&
                _editLivro!.autor != null &&
                _editLivro!.autor.isNotEmpty &&
                _editLivro!.anopubli != null &&
                _editLivro!.anopubli.isNotEmpty &&
                _editLivro!.editora != null &&
                _editLivro!.editora.isNotEmpty &&
                _editLivro!.genero != null &&
                _editLivro!.genero.isNotEmpty) {
              Navigator.pop(context, _editLivro);
            } else {
              //   FocusScope.of(context).requestFocus(_tituloFocus);
              // FocusScope.of(context).requestFocus(_anopubliFocus);
              //FocusScope.of(context).requestFocus(_generoFocus);
              //FocusScope.of(context).requestFocus(_autorFocus);
              //FocusScope.of(context).requestFocus(_editoraFocus);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Campo obrigatório'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              // Garante o formato circular
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 174, 174, 174),
                  Color.fromARGB(255, 255, 254, 254),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(Icons.save),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/imgs/Books.jpg',
                ),
                fit: BoxFit.cover

                /*  colorFilter: ColorFilter.mode(
                      Colors.white
                          .withOpacity(0.7), // Define a transparência da imagem
                      BlendMode.dstATop),*/

                ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextField(
                controller: _tituloController,
                focusNode: _tituloFocus,
                decoration: const InputDecoration(
                  labelText: "Titulo",
                  filled: true, // Ativa o preenchimento com cor
                  //   fillColor: Color.fromARGB(255, 163, 161, 161),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 148, 145, 145),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 150, 148, 148)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(
                          255, 124, 121, 121)), // Cor do texto do label
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 158, 159, 160)),
                ),
                onChanged: (text) {
                  _userEdit = true;
                  setState(() {
                    _editLivro!.titulo = text;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _autorController,
                focusNode: _autorFocus,
                decoration: const InputDecoration(
                  labelText: "Autor",
                  filled: true, // Ativa o preenchimento com cor
                  //   fillColor: Color.fromARGB(255, 163, 161, 161),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 148, 145, 145),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 150, 148, 148)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(
                          255, 124, 121, 121)), // Cor do texto do label
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 158, 159, 160)),
                ),
                onChanged: (text) {
                  _userEdit = true;

                  _editLivro!.autor = text;
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _anopubliController,
                focusNode: _anopubliFocus,
                decoration: const InputDecoration(
                  labelText: "Ano de Publicação",
                  filled: true, // Ativa o preenchimento com cor
                  //   fillColor: Color.fromARGB(255, 163, 161, 161),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 148, 145, 145),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 150, 148, 148)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(
                          255, 124, 121, 121)), // Cor do texto do label
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 158, 159, 160)),
                ),
                onChanged: (text) async {
                  _userEdit = true;

                  _editLivro!.anopubli = text;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Filtra apenas números inteiros
                ],
              ),
              SizedBox(height: 20),

              /*  controller: _generoControler,
                  focusNode: _generoFocus,
                  decoration: const InputDecoration(

                    labelText: "Gênero",
                    filled: true, // Ativa o preenchimento com cor
                    //   fillColor: Color.fromARGB(255, 163, 161, 161),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 148, 145, 145),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 150, 148, 148)),
                    ),
                    labelStyle: TextStyle(
                        color: Color.fromARGB(
                            255, 124, 121, 121)), // Cor do texto do label
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 158, 159, 160)),
                  ),
                  onChanged: (text) {
                    _userEdit = true;

                    _editLivro!.genero = text;
                  },
                  */

              TextField(
                  controller: _editoraControler,
                  focusNode: _editoraFocus,
                  decoration: const InputDecoration(
                    labelText: "Editora",
                    filled: true, // Ativa o preenchimento com cor
                    //   fillColor: Color.fromARGB(255, 163, 161, 161),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 148, 145, 145),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 150, 148, 148)),
                    ),
                    labelStyle: TextStyle(
                        color: Color.fromARGB(
                            255, 124, 121, 121)), // Cor do texto do label
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 158, 159, 160)),
                  ),
                  onChanged: (text) {
                    _userEdit = true;

                    _editLivro!.editora = text;
                  },
                  keyboardType: TextInputType.text),
              SizedBox(height: 10),
              Container(
                child: Text(
                  "Gênero",
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                //  color: Colors.white,
              ),
              Chip(
                label: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownvalue,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _userEdit = true;
                        _editLivro?.genero = value!;
                        dropdownvalue = value!;
                      });
                    },
                    isDense: true,
                  ),
                ),
              ),
              /* Card(
                child: Column(
                  children: <Widget>[
                    DropdownButton<String>(
                        value: dropdownvalue,
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _userEdit = true;
                            _editLivro?.genero = value!;
                            dropdownvalue = value!;
                          });
                        }),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdit) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Descartar Alterações"),
            content: Text("Se sair as alterações serão perdidas!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("cancelar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("sim"),
              ),
            ],
          );
        },
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}

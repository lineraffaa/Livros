import 'package:biblioteca/helpers/livro_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:biblioteca/view/livro_page.dart';
import 'livro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LivroHelper helper = LivroHelper();
  List<Livro> livros = [];

  bool isSelected = false;

  void alert(Livro livro, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Tem certeza que deseja excluir os livros?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              helper.deleteLivro(livros[index].id);
              setState(
                () {
                  livros.removeAt(index);
                  Navigator.pop(context);
                },
              );
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context, "Cancelar"),
              child: Text('Cancelar'))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getAllLivros();
  }

  void _getAllLivros() {
    helper.getAllLivros().then((list) {
      setState(() {
        livros = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 126, 124, 124),
                ], // Gradiente de cores
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              /*   image: DecorationImage(
                  image: AssetImage('assets/imgs/bookgameremove.png'),
                  fit: BoxFit.contain),*/
            ),
          ),
          title: const Text(
            "Livros",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/imgs/book4.jpg',
                ),
                fit: BoxFit.cover

                /*  colorFilter: ColorFilter.mode(
                      Colors.white
                          .withOpacity(0.7), // Define a transparência da imagem
                      BlendMode.dstATop),*/

                ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: livros.length,
            itemBuilder: (context, index) {
              return _livrosCard(context, index);
            },
          ),
        ),
        // height: double.infinity,
        //  width: double.infinity,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showLivroPage(livro: Livro());
          },
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle, // Garante o formato circular
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 250, 250),
                  Color.fromARGB(255, 176, 176, 176),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.add,
            ),
          ),
        ));
  }

/*
     floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLivroPage(livro: Livro());
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.blue,
      ),
    );*/

  Widget _livrosCard(BuildContext context, int index) {
    return GestureDetector(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.910), // Transparente
              borderRadius: BorderRadius.circular(12.0),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 114, 113, 113),
                  Color.fromARGB(255, 255, 255, 255),

                  // Branco com 50% de opacidade Color.fromARGB(255, 148, 148, 148).withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    'Titulo',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  selected: isSelected,
                  // selectedTileColor: Colors.amber,
                  subtitle: Text(livros[index].titulo ?? " ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.book_rounded,
                    color: const Color.fromARGB(255, 78, 78, 79),
                  ),
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  selectedColor: const Color.fromARGB(255, 0, 0, 0),
                ),

                /*    Text(
                  'Autor: ${livros[index].autor ?? " "}',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),*/
                ListTile(
                  subtitle: Text(livros[index].autor ?? " ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  title: Text(
                    "Autor",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  leading: Icon(
                    Icons.people_outline,
                    color: const Color.fromARGB(255, 78, 78, 79),
                  ),
                ),
                ListTile(
                  subtitle: Text(livros[index].anopubli ?? " ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  title: Text(
                    "Ano de Publicação",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  leading: Icon(
                    Icons.numbers,
                    color: const Color.fromARGB(255, 78, 78, 79),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Genêro",
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(livros[index].genero ?? " ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.emoji_objects_rounded,
                    color: const Color.fromARGB(255, 78, 78, 79),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Editora",
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(livros[index].editora ?? " ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.perm_identity,
                    color: const Color.fromARGB(255, 78, 78, 79),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // _showLivroPage(livro: livros[index]);
        _ShowOptions(context, index);
      },
    );
  }

  void _showLivroPage({required Livro livro}) async {
    final recLivro = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivroPage(
          livro: livro,
        ),
      ),
    );
    // print(recLivro);
    if (recLivro != null) {
      if (recLivro.titulo != "" &&
          recLivro.autor != "" &&
          recLivro.anopubli != "" &&
          recLivro.genero != "" &&
          recLivro.editora != "") {
        if (recLivro.id != null) {
          await helper.updateLivro(recLivro);
        } else {
          await helper.saveLivro(recLivro);
        }
      } else {
//here
      }
      _getAllLivros();
    }
  }

  void _ShowOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.00),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton(
                      tooltip: 'Editar',
                      onPressed: () {
                        Navigator.pop(context);
                        _showLivroPage(livro: livros[index]);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // Garante o formato circular
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 247, 247, 247),
                              Color.fromARGB(255, 176, 176, 176),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    FloatingActionButton(
                      tooltip: 'Excluir',
                      onPressed: () {
                        alert(livros[index], index);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // Garante o formato circular
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 247, 247, 247),
                              Color.fromARGB(255, 176, 176, 176),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}

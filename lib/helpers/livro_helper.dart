import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String idColumn = "idColumn";
const String tituloColumn = "tituloColumn";
const String autorColumn = "autorColumn";
const String ano_publiColumn = "anopubliColumn";
const String generoColumn = "generoColumn";
const String editoraColumn = "editoraColumn";
const String livroTable = "livroTable";

class LivroHelper {
  static final LivroHelper _instance = LivroHelper.internal();
  factory LivroHelper() => _instance;
  LivroHelper.internal();

  Database? _db;

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "livros.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newVersion) async {
        await db.execute(
            "CREATE TABLE $livroTable($idColumn INTEGER PRIMARY KEY, $tituloColumn TEXT, $generoColumn TEXT, $ano_publiColumn TEXT, $autorColumn TEXT, $editoraColumn TEXT)");
      },
    );
  }

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<List<Livro>> getAllLivros() async {
    final dbLivro = await db;
    final List<Map<String, dynamic>> maps = await dbLivro.query(livroTable);

    return List.generate(maps.length, (i) {
      return Livro.fromMap(maps[i]);
    });
  }

  Future<Livro?> getLivro(int id) async {
    final dbLivro = await db;
    final List<Map<String, dynamic>> maps = await dbLivro.query(
      livroTable,
      columns: [
        idColumn,
        tituloColumn,
        ano_publiColumn,
        editoraColumn,
        generoColumn,
      ],
      where: "$idColumn = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Livro.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Livro> saveLivro(Livro livro) async {
    final dbLivro = await db;
    livro.id = await dbLivro.insert(livroTable, livro.toMap());
    return livro;
  }

  Future<int> updateLivro(Livro livro) async {
    final dbLivro = await db;
    return await dbLivro.update(
      livroTable,
      livro.toMap(),
      where: "$idColumn = ?",
      whereArgs: [livro.id],
    );
  }

  Future<int> deleteLivro(int? id) async {
    final dbLivro = await db;
    return await dbLivro.delete(
      livroTable,
      where: "$idColumn = ?",
      whereArgs: [id],
    );
  }
}

class Livro {
  int? id;
  late String titulo;
  late String autor;
  late String anopubli;
  late String editora;
  late String genero;

  Livro({
    this.id,
    this.titulo = '',
    this.autor = '',
    this.anopubli = '',
    this.genero = '',
    this.editora = '',
  });

  Livro.fromMap(Map<String, dynamic> map) {
    id = map[idColumn] as int?;
    titulo = map[tituloColumn] != null ? map[tituloColumn].toString() : '';
    autor = map[autorColumn] != null ? map[autorColumn].toString() : '';
    anopubli =
        map[ano_publiColumn] != null ? map[ano_publiColumn].toString() : '';
    genero = map[generoColumn] != null ? map[generoColumn].toString() : '';
    editora = map[editoraColumn] != null ? map[editoraColumn].toString() : '';
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tituloColumn: titulo,
      autorColumn: autor,
      ano_publiColumn: anopubli,
      generoColumn: genero,
      editoraColumn: editora,
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Livro(id: $id, titulo: $titulo, autor: $autor, ano de publicação: $anopubli, gênero: $genero, editora: $editora)";
  }
}

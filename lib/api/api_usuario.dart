import 'dart:convert' as convert;
import 'package:ceiba_app/modelo/mod_post.dart';
import 'package:http/http.dart' as http;
import 'package:ceiba_app/modelo/mod_usuario.dart';

class UsuarioApi {
  Future<List<Usuario>> consultaUsuarios() async {
    var respuesta =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    Iterable objeto = convert.json.decode(respuesta.body);

    if (respuesta.statusCode == 200) {
      return objeto
          .map((usuarioRecibido) => Usuario.fromJson(usuarioRecibido))
          .toList();
    } else {
      throw Exception("No se logro cargar el api de la ruta");
    }
  }

  Future<List<Post>> consultaPost(int id) async {
    var respuesta = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts?userId=$id"));

    Iterable objeto = convert.json.decode(respuesta.body);

    if (respuesta.statusCode == 200) {
      return objeto.map((postRecibido) => Post.fromJson(postRecibido)).toList();
    } else {
      throw Exception("No se logro cargar el api de libros");
    }
  }
}

import 'package:ceiba_app/api/api_usuario.dart';
import 'package:ceiba_app/modelo/mod_post.dart';
import 'package:ceiba_app/modelo/mod_usuario.dart';
import 'package:ceiba_app/utilidades/hive.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  HiveDatabase localDatabase = HiveDatabase.instance;
  late Usuario usuario = localDatabase.boxUsuario.getAt(0);
  late String mensaje;
  bool isLoading = false;
  late bool error;
  late bool terminada;
  late bool _isUploading;
  var listaUsuario = [];
  var listaDummySearch = [];
  var listaPost = [];

  bool get isUploading => _isUploading;

  void init() async {
    if (localDatabase.boxUsuario.isEmpty) {
      cargarlista();
    }
    notifyListeners();
  }

  insert(Usuario usuario) {
    localDatabase.boxUsuario.add(usuario);
    listaUsuario.add(usuario);
    notifyListeners();
  }

  insertPost(Post post) {
    listaPost.add(post);
    notifyListeners();
  }

  resetEntrada() {
    listaUsuario =
        localDatabase.boxUsuario.values.where((element) => true).toList();
    listaDummySearch =
        localDatabase.boxUsuario.values.where((element) => true).toList();
    notifyListeners();
  }

  filtrarEntrada(String texto) {
    texto = texto.toUpperCase();
    listaUsuario = listaDummySearch.where((element) {
      var punto = element.name.toUpperCase();
      return punto.contains(texto);
    }).toList();

    notifyListeners();
  }

  Future retornaDatos() async {
    if (localDatabase.boxUsuario.isNotEmpty) {
      return listaUsuario;
    }
  }

  cargarlista() async {
    //Se llama el api
    await UsuarioApi().consultaUsuarios().then((listaUsuarios) {
      // ignore: avoid_function_literals_in_foreach_calls
      listaUsuarios.forEach((usuarios) => insert(usuarios));
      mensaje = "Se realizo la sincronizacion correctamente!";
      notifyListeners();
    }).catchError((e) {
      mensaje = "No se lograron enviar los datos al servidor";
      notifyListeners();
    });
  }

  Future retornaDatosPost() async {
    if (listaPost.isNotEmpty) {
      return listaPost;
    }
  }

  cargarlistaPost(int id) async {
    listaPost = [];
    //Se llama el api
    UsuarioApi().consultaPost(id).then((listaPost) {
      listaPost.forEach((post) => insertPost(post));
      mensaje = "Se realizo la sincronizacion correctamente!";
      notifyListeners();
    }).catchError((e) {
      mensaje = "No se lograron enviar los datos de la api";
      notifyListeners();
    });
  }
}

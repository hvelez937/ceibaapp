import 'package:ceiba_app/api/api_usuario.dart';
import 'package:ceiba_app/modelo/mod_usuario.dart';
import 'package:ceiba_app/provider/provider_usuario.dart';
import 'package:ceiba_app/ui/list_post.dart';
import 'package:ceiba_app/utilidades/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var usuarioProvider = Provider.of<UsuarioProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Prueba de Ingreso"),
          backgroundColor: green,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(3.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: editingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Buscar por Nombre',
                  hintText: 'Buscar por Nombre',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffix: GestureDetector(
                    child: const Icon(Icons.close),
                    onTap: () {
                      usuarioProvider.resetEntrada();
                      editingController.clear();
                    },
                  ),
                ),
                onChanged: (text) {
                  usuarioProvider.filtrarEntrada(text);
                  if (text.isEmpty) {
                    usuarioProvider.resetEntrada();
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                  future: usuarioProvider.retornaDatos(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: usuarioProvider.listaUsuario.length,
                          itemBuilder: (context, index) {
                            Usuario usuario =
                                usuarioProvider.listaUsuario[index];

                            return Card(
                              elevation: 30,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: const EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: Colors.orange,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 25.0,
                                      child: Text(usuario.name,
                                          style: TextStyle(
                                              color: green, fontSize: 20.0)),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: green,
                                            size: 25.0,
                                          ),
                                          Text(usuario.phone,
                                              style: const TextStyle(
                                                  fontSize: 15.0)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: green,
                                            size: 25.0,
                                          ),
                                          Text(usuario.email,
                                              style: const TextStyle(
                                                  fontSize: 15.0)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          child:
                                              const Text('VER PUBLICACIONES'),
                                          style: TextButton.styleFrom(
                                            primary: green,
                                          ),
                                          onPressed: () {
                                            usuarioProvider
                                                .cargarlistaPost(usuario.id);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PostPage(usuario: usuario),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  })
            ],
          ),
        ));
  }
}

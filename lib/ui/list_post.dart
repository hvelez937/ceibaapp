import 'package:ceiba_app/modelo/mod_post.dart';
import 'package:ceiba_app/modelo/mod_usuario.dart';
import 'package:ceiba_app/provider/provider_usuario.dart';
import 'package:ceiba_app/utilidades/constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    var usuarioProvider = Provider.of<UsuarioProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Publicaciones"),
          backgroundColor: green,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: usuarioProvider.retornaDatosPost(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
                padding: const EdgeInsets.all(3.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.usuario.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: green,
                          size: 25.0,
                        ),
                        Text(widget.usuario.phone,
                            style: const TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: green,
                          size: 25.0,
                        ),
                        Text(widget.usuario.email,
                            style: const TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: usuarioProvider.listaPost.length,
                          itemBuilder: (context, index) {
                            Post post = usuarioProvider.listaPost[index];

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
                                    ListTile(
                                      leading: Icon(
                                        Icons.post_add_rounded,
                                        color: green,
                                        size: 30.0,
                                      ),
                                      title: Text(post.title,
                                          style: TextStyle(
                                              color: green, fontSize: 18.0)),
                                      subtitle: Text(
                                        post.body,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              );
            }));
  }
}

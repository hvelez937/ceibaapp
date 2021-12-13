import 'package:ceiba_app/provider/provider_usuario.dart';
import 'package:ceiba_app/ui/lista_usuario.dart';
import 'package:ceiba_app/utilidades/hive.dart';
import 'package:ceiba_app/utilidades/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HiveDatabase localDatabase = HiveDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => UsuarioProvider()..init()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, // eliminar banner
          home: FutureBuilder(
            future: localDatabase.initDatabase(),
            builder: (context, snapshot) {
              return UsuarioPage();
            },
          ),
          routes: buildAppRoutes(),
        ));
  }
}

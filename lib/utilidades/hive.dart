import 'package:ceiba_app/modelo/mod_usuario.dart';
import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  late Box boxUsuario;

  static HiveDatabase? _instance;

  HiveDatabase._internal();

  static HiveDatabase get instance {
    _instance ??= HiveDatabase._internal();
    return _instance!;
  }

  Future<bool> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    await Future.sync(() => Hive.registerAdapter(UsuarioAdapter()));
    boxUsuario = await Hive.openBox<Usuario>("usuario");
    return true;
  }
}

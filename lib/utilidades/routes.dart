import 'package:ceiba_app/ui/lista_usuario.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/lista': (BuildContext context) => UsuarioPage(),
  };
}

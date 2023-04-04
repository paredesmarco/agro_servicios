import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:get/get.dart';

class HomeRepository {
  final _dbHome = Get.find<DBHomeProvider>();

  ///
  ///Retorna el usuario guardado en la aplicación[UsuarioModelo]
  ///
  Future<UsuarioModelo?> getUsuario() async => _dbHome.getUsuario();

  ///
  ///Retorna el usuario guardado en la aplicación[UsuarioModelo]
  ///
  Future<void> guardarUsuario(UsuarioModelo usuario) async =>
      _dbHome.nuevoUsuario(usuario);
}

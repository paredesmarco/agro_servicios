import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/repository/minador_sv_repository.dart';
import 'package:get/get.dart';

///Controlador solo para manejar los tabs de Formulario
///Relacionada con Pagr minador_form_sv
class MinadorVerController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final minadorRepositorio = Get.find<MinadorRepository>();

  List<MinadorModelo> listMinadorView = [];

  @override
  void onInit() {
    getInspecciones();
    super.onInit();
  }

  @override
  void onReady() {
    getInspecciones();

    super.onReady();
  }

  Future<void> getInspecciones() async {
    UsuarioModelo? listaUsuario = UsuarioModelo();
    listaUsuario = await DBHomeProvider.db.getUsuario();
    String usuarioId = listaUsuario!.identificador.toString();

    listMinadorView.clear();
    listMinadorView = await minadorRepositorio.getMinadorModeloLista(usuarioId);
    update(['ver']);
  }
}

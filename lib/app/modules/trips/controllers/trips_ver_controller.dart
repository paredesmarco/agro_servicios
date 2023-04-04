import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/repository/trips_sv_repository.dart';
import 'package:get/get.dart';

///Controlador solo para manejar los tabs de Formulario
///Relacionada con Pagr trip_form_sv
class TripsVerController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final tripsRepositorio = Get.find<TripsRepository>();

  List<TripsModelo> listTripsView = [];

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

    listTripsView.clear();
    listTripsView = await tripsRepositorio.getTripsModeloLista(usuarioId);
    update(['ver']);
  }
}

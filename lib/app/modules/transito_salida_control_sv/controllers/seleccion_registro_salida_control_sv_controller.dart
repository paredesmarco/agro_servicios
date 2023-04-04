import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/data/repository/transito_salida_control_sv_repository.dart';
import 'package:get/get.dart';

class SeleccionRegistroSalidaControlSvController extends GetxController
    with ControladorBase {
  @override
  void onReady() async {
    super.onReady();
    obtenerRegistros();
  }

  final _repositorio = Get.find<TransitoSalidaControlSvRepository>();

  RxList<RegistrosTransitoIngresoModelo> registrosIngreso =
      <RegistrosTransitoIngresoModelo>[].obs;

  Future<void> obtenerRegistros() async {
    final res = _repositorio.getRegistrosIngresoSincronizados();

    registrosIngreso.value = await res;
  }

  Future<bool> comprobarLlenado(int idRegistro) async {
    final res = await _repositorio.getVerificacionSalidaLlenado(idRegistro);

    if (res?.idIngreso == idRegistro) {
      return true;
    } else {
      return false;
    }
  }
}

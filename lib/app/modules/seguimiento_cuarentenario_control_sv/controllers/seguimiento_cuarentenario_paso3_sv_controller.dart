import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:get/get.dart';

class SeguimientoCuarentenarioPaso3vController extends GetxController {
  final _controlador = Get.find<SeguimientoCuarentenarioSvController>();
  final RxString _envioMuestra = 'No'.obs;

  RxString get envioMuestra => _envioMuestra;

  RxList<SeguimientoCuarentenarioLaboratorioSvModelo> get listaLaboratorio =>
      _controlador.listaLaboratorio;

  @override
  void onInit() {
    Get.find<SeguimientoCuarentenarioSvController>()
        .seguimientoModelo
        .envioMuestra = 'No';
    super.onInit();
  }

  set envioMuestra(valor) {
    _envioMuestra.value = valor;
    update(['idEnvioMuestra']);
    _controlador.envioMuestra = valor == 'Si' ? true : false;
    Get.find<SeguimientoCuarentenarioSvController>()
        .seguimientoModelo
        .envioMuestra = valor;
  }

  bool validarFormulario() {
    bool esValido = true;
    if (_controlador.envioMuestra) {
      if (Get.find<SeguimientoCuarentenarioSvController>()
          .listaLaboratorio
          .isEmpty) {
        esValido = false;
      }
    }

    return esValido;
  }

  set eliminarIndex(int index) => _controlador.eliminarOrdenLaboratorio(index);
}

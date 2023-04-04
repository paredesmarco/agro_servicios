import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_verificacion_control_sv.dart';

class EmbalajeIncumplimientoControlSvController extends GetxController {
  final _ctrVerificacion = Get.find<EmbalajeVerificacionControlSvController>();
  final _controlador = Get.find<EmbalajeControlSvController>();

  RxList<EmbalajeControlLaboratorioSvModelo> listaLaboratorio =
      <EmbalajeControlLaboratorioSvModelo>[].obs;

  String? _envioMuestra = 'No';

  String? errorRazonSocial;
  String? errorManiifiestoCarga;
  String? errorProducto;

  RxBool tieneMuestra = false.obs;

  set razonSocial(valor) => _controlador.embalajeModelo.razonSocial = valor;

  set manifiestoCarga(valor) => _controlador.embalajeModelo.manifesto = valor;

  set producto(valor) => _controlador.embalajeModelo.producto = valor;

  get producto => _controlador.embalajeModelo.producto;

  get envioMuestra => _envioMuestra;
  set envioMuestra(valor) {
    _envioMuestra = valor;
    _controlador.embalajeModelo.envioMuestra = valor;
    tieneMuestra.value = valor == 'Si' ? true : false;
    update(['idMuestra']);
  }

  void eliminarOrdenLaboratorio() {
    listaLaboratorio.clear();
    _controlador.laboratorioModelo.limpiarModelo();
  }

  bool validarFormulario() {
    bool esValido = true;
    final bool incumple = _ctrVerificacion.validarIncumplimiento();
    if (incumple) {
      if (_controlador.embalajeModelo.razonSocial == null) {
        errorRazonSocial = CAMPO_REQUERIDO;
        esValido = false;
      } else {
        errorRazonSocial = null;
      }

      if (_controlador.embalajeModelo.manifesto == null) {
        errorManiifiestoCarga = CAMPO_REQUERIDO;
        esValido = false;
      } else {
        errorManiifiestoCarga = null;
      }

      if (_controlador.embalajeModelo.producto == null) {
        errorProducto = CAMPO_REQUERIDO;
        esValido = false;
      } else {
        errorProducto = null;
      }
    } else {
      errorRazonSocial = null;
      errorManiifiestoCarga = null;
      errorProducto = null;
    }

    update([
      'idRazonSocial',
      'idManifiesto',
      'idProducto',
    ]);

    return esValido;
  }
}

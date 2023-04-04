import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv_modelo.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvCultivoController extends GetxController {
  String? errorEspecie;
  String? errorVariedad;
  String? errorAreaProduccion;

  CaracterizacionFrMfSvModelo caracteizacionModelo =
      CaracterizacionFrMfSvModelo();

  set setEspecie(valor) => caracteizacionModelo.especie = valor;

  set setVariedad(valor) => caracteizacionModelo.variedad = valor;

  set setArea(valor) => caracteizacionModelo.areaProduccionEstimada = valor;

  set setObservacion(valor) => caracteizacionModelo.observaciones = valor;

  bool validarFormulario() {
    bool esValido = true;

    if (caracteizacionModelo.especie == null ||
        caracteizacionModelo.especie == '') {
      errorEspecie = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorEspecie = null;
    }

    if (caracteizacionModelo.variedad == null ||
        caracteizacionModelo.variedad == '') {
      errorVariedad = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorVariedad = null;
    }

    if (!validarDouble(caracteizacionModelo.areaProduccionEstimada)) {
      errorAreaProduccion = CAMPO_NUMERICO_VALIDO;

      esValido = false;
    } else {
      errorAreaProduccion = null;
    }

    update(['idValidacion']);

    return esValido;
  }
}

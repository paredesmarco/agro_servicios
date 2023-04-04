import 'package:agro_servicios/app/data/models/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv_modelo.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvProductorController extends GetxController {
  String? errorNombre;
  String? errorIdentificador;
  String? errorTelefono;

  CaracterizacionFrMfSvModelo caracteizacionModelo =
      CaracterizacionFrMfSvModelo();

  set setNombre(valor) =>
      caracteizacionModelo.nombreAsociacionProductor = valor;

  set setIdentificador(valor) => caracteizacionModelo.identificador = valor;

  set setTelefono(valor) => caracteizacionModelo.telefono = valor;

  bool validarFormulario() {
    bool esValido = true;

    if (caracteizacionModelo.nombreAsociacionProductor == null ||
        caracteizacionModelo.nombreAsociacionProductor == '') {
      errorNombre = 'Campo requerido';
      esValido = false;
    } else {
      errorNombre = null;
    }

    if (caracteizacionModelo.identificador == null ||
        caracteizacionModelo.identificador == '') {
      errorIdentificador = 'Campo requerido';
      esValido = false;
    } else {
      errorIdentificador = null;
    }

    if (caracteizacionModelo.telefono == null ||
        caracteizacionModelo.telefono == '') {
      errorTelefono = 'Campo requerido';

      esValido = false;
    } else {
      errorTelefono = null;
    }

    update(['idValidacion']);

    return esValido;
  }
}

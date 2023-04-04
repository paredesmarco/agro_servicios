import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/embalaje_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_incumplimiento_control_sv_controller.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EmbalajeLaboratorioControlSvController extends GetxController {
  @override
  void onReady() {
    producto.value = Get.arguments;
    _controlador.laboratorioModelo.nombreProducto = producto.value;
    generarCodigo();
    super.onReady();
  }

  final _controlador = Get.find<EmbalajeControlSvController>();
  final ctrIncumplimiento =
      Get.find<EmbalajeIncumplimientoControlSvController>();

  final _embalajeRepository = Get.find<EmbalajeControlSvRepository>();

  EmbalajeControlLaboratorioSvModelo laboratorioModelo =
      EmbalajeControlLaboratorioSvModelo();

  RxBool esIdentificacionInsectos = false.obs;
  RxBool esExtracion01 = false.obs;
  RxBool esExtracion02 = false.obs;
  RxBool esExtracion03 = false.obs;
  RxBool esExtracion06 = false.obs;
  RxBool esExtracion09 = false.obs;
  RxBool esExtracion12 = false.obs;
  RxBool esExtracion14 = false.obs;
  RxBool esIdentificacionBacterias = false.obs;
  RxBool esIdentificacionHongos = false.obs;
  RxBool esDiagnostico = false.obs;

  RxBool validandoGuardado = true.obs;

  RxString producto = ''.obs;
  RxString codigoMuestra = ''.obs;
  RxString mensajeGuardado = ''.obs;
  String? estadoGuardado;
  String? provincia;

  String _identificacionInsectos = '';
  String _extracion01 = '';
  String _extracion02 = '';
  String _extracion03 = '';
  String _extracion06 = '';
  String _extracion09 = '';
  String _extracion12 = '';
  String _extracion14 = '';
  String _identificacionBacterias = '';
  String _identificacionHongos = '';
  String _diagnostico = '';

  String? errorProducto;
  String? errorTipoCliente;
  String? errorTipoMuestra;
  String? errorConservacion;
  String? errorActividadOrigen;
  String? errorPeso;
  String? errorPrediagnostico;
  String? errorDescripcionSintomas;
  String? errorFaseFenologica;

  // set producto(valor) => laboratoriomodelo.nombreProducto = valor;

  set tipoCliente(valor) => _controlador.laboratorioModelo.tipoCliente = valor;

  set tipoMuestra(valor) => _controlador.laboratorioModelo.tipoMuestra = valor;

  set conservacion(valor) =>
      _controlador.laboratorioModelo.conservacion = valor;

  set actividadOrigen(valor) =>
      _controlador.laboratorioModelo.actividadOrigen = valor;

  set peso(valor) => _controlador.laboratorioModelo.pesoMuestra = valor;

  set prediagnostico(valor) =>
      _controlador.laboratorioModelo.prediagnostico = valor;

  set descripcionSintomas(valor) =>
      _controlador.laboratorioModelo.descripcionSintomas = valor;

  set faseFenologica(valor) =>
      _controlador.laboratorioModelo.faseFenologica = valor;

  set identificacionInsectos(bool valor) {
    esIdentificacionInsectos.value = valor;
    if (valor) {
      _identificacionInsectos = 'Identificación general de insectos';
    } else {
      _identificacionInsectos = '';
    }
  }

  set extracion01(bool valor) {
    esExtracion01.value = valor;
    if (valor) {
      _extracion01 = ', Extracción de nemátodos (PEE/N/01)';
    } else {
      _extracion01 = '';
    }
  }

  set extracion02(bool valor) {
    esExtracion02.value = valor;
    if (valor) {
      _extracion02 = ', Extracción de nemátodos (PEE/N/02)';
    } else {
      _extracion02 = '';
    }
  }

  set extracion03(bool valor) {
    esExtracion03.value = valor;
    if (valor) {
      _extracion03 = ', Extracción de nemátodos (PEE/N/03)';
    } else {
      _extracion03 = '';
    }
  }

  set extracion06(bool valor) {
    esExtracion06.value = valor;
    if (valor) {
      _extracion06 = ', Extracción de nemátodos (PEE/N/06)';
    } else {
      _extracion06 = '';
    }
  }

  set extracion09(bool valor) {
    esExtracion09.value = valor;
    if (valor) {
      _extracion09 = ', Extracción de nemátodos (PEE/N/12)';
    } else {
      _extracion09 = '';
    }
  }

  set extracion12(bool valor) {
    esExtracion12.value = valor;
    if (valor) {
      _extracion12 = ', Extracción de nemátodos (PEE/N/12)';
    } else {
      _extracion12 = '';
    }
  }

  set extracion14(bool valor) {
    esExtracion14.value = valor;
    if (valor) {
      _extracion14 = ', Extracción de nemátodos (PEE/N/14)';
    } else {
      _extracion14 = '';
    }
  }

  set identificacionBacterias(bool valor) {
    esIdentificacionBacterias.value = valor;
    if (valor) {
      _identificacionBacterias =
          ', Identificación de bacterias fitopatógenas hasta especie (PEE/FP/01)';
    } else {
      _identificacionBacterias = '';
    }
  }

  set identificacionHongos(bool valor) {
    esIdentificacionHongos.value = valor;
    if (valor) {
      _identificacionHongos =
          ', Identificación de hongos fitopatógenos hasta especie (PEE/FP/10)';
    } else {
      _identificacionHongos = '';
    }
  }

  set diagnostico(bool valor) {
    esDiagnostico.value = valor;
    if (valor) {
      _diagnostico =
          ', Diagnóstico de virus por el método ELISA DAS (PEE/FP/11)';
    } else {
      _diagnostico = '';
    }
  }

  Future<void> generarCodigo() async {
    final provinciaContrato = await _embalajeRepository.getProvinciaContrato();

    final fecha = DateTime.now().toUtc().millisecondsSinceEpoch.toString();

    String codigo = generarCodigoMuestra(
        provincia: provinciaContrato?.provincia ?? '',
        secuencia: 0,
        fechaInicial: fecha.toString(),
        codigoFormulario: 'SIN');

    _controlador.laboratorioModelo.codigoMuestra = codigo;
    codigoMuestra.value = codigo;
  }

  void _llenarAnalisis() {
    String? analisis;
    analisis = '';
    analisis = _identificacionInsectos +
        _extracion01 +
        _extracion02 +
        _extracion03 +
        _extracion06 +
        _extracion09 +
        _extracion12 +
        _extracion14 +
        _identificacionBacterias +
        _identificacionHongos +
        _diagnostico;
    analisis = removerNprimerosCaracteres(
        cadena: analisis, caracterSeparador: ',', cantidad: 2);

    _controlador.laboratorioModelo.analisis = analisis;
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeGuardado.value = mensaje ?? 'Sincronizando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeGuardado.value = mensaje;
  }

  bool validarFormulario() {
    _llenarAnalisis();

    bool esValido = true;

    if (_controlador.laboratorioModelo.tipoCliente == null) {
      errorTipoCliente = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorTipoCliente = null;
    }
    if (_controlador.laboratorioModelo.tipoMuestra == null) {
      errorTipoMuestra = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorTipoMuestra = null;
    }

    if (_controlador.laboratorioModelo.conservacion == null) {
      errorConservacion = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorConservacion = null;
    }

    if (_controlador.laboratorioModelo.actividadOrigen == null) {
      errorActividadOrigen = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorActividadOrigen = null;
    }

    if (!validarDouble(_controlador.laboratorioModelo.pesoMuestra)) {
      errorPeso = CAMPO_NUMERICO_VALIDO;
      esValido = false;
    } else {
      errorPeso = null;
    }

    if (_controlador.laboratorioModelo.prediagnostico == null ||
        _controlador.laboratorioModelo.prediagnostico == '') {
      errorPrediagnostico = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorPrediagnostico = null;
    }

    if (_controlador.laboratorioModelo.descripcionSintomas == null ||
        _controlador.laboratorioModelo.descripcionSintomas == '') {
      errorDescripcionSintomas = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorDescripcionSintomas = null;
    }

    if (_controlador.laboratorioModelo.faseFenologica == null ||
        _controlador.laboratorioModelo.faseFenologica == '') {
      errorFaseFenologica = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorFaseFenologica = null;
    }

    update(['idValidacion']);

    return esValido;
  }

  Future<void> guardarformulario(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    iniciarValidacion(mensaje: DEFECTO_A);
    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    ctrIncumplimiento.listaLaboratorio.add(_controlador.laboratorioModelo);

    await Future.delayed(const Duration(seconds: 1));
    finalizarValidacion('Almacenando exitosamente');
    await Future.delayed(const Duration(seconds: 1));

    Get.back();
    Get.back();
  }
}

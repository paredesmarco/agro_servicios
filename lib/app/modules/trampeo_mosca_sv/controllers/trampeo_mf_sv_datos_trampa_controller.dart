import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_lugar_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_pasos_controller.dart';
import 'package:agro_servicios/app/data/models/login/usurio_modelo.dart';
import 'package:agro_servicios/app/data/repository/home_repository.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_detalle_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/utils/utils.dart' as utils;

class TrampeoMfSvDatosTrampaController extends GetxController {
  final _homeRepositorio = Get.find<HomeRepository>();

  final ctrPrincipal = Get.find<TrampeoMfSvController>();

  TrampasMfSvModelo? _trampa;
  final TrampasMfSvDetalleModelo _trampaDetalle = TrampasMfSvDetalleModelo();

  String _cambioTrampa = '';
  String _cambioPlug = '';
  String _envioMuestra = '';

  String? errorCondicion;
  String? errorCambioTrampa;
  String? errorCambioPlug;
  String? errorEspeciePrincipal;
  String? errorFenologicoPrincipal;
  String? errorEspecieColindante;
  String? errorFenologicoColindante;
  String? errorNumeroEspecimenes;
  String? errorEnvioMuestra;
  String? errorObservacion;

  bool? sinCambioTrampa;
  bool? sinCambioPlug;
  bool? sinEnvioMuestra;
  bool estaLLenado = false;

  int index = 0;

  var mensajeBajarDatos = 'Sincronizando...'.obs;
  var validandoBajada = true.obs;

  var numeroEspecimenesTextController = TextEditingController();
  var observacionTextController = TextEditingController();

  @override
  void onInit() {
    final args = Get.arguments;
    _trampa = args['parametro']!;
    verificarTrampaLlenada();
    super.onInit();
  }

  @override
  void onClose() {
    numeroEspecimenesTextController.dispose();
    super.onClose();
  }

  void verificarTrampaLlenada() {
    Get.find<TrampeoMfSvController>().listaTrampasDetalle.asMap().forEach(
      (i, value) {
        if (value.codigoTrampa == _trampa!.codigoTrampa!) {
          if (_trampa!.llenado) {
            estaLLenado = true;
          }
          index = i;
        }
      },
    );

    if (estaLLenado) {
      llenarFormulario(index);
    }
  }

  void llenarFormulario(int index) {
    List<TrampasMfSvDetalleModelo> trampaDetalle =
        Get.find<TrampeoMfSvController>().listaTrampasDetalle;
    _cambioTrampa = trampaDetalle[index].cambioTrampa!;
    _trampaDetalle.cambioTrampa = trampaDetalle[index].cambioTrampa;
    _cambioPlug = trampaDetalle[index].cambioPlug!;
    _trampaDetalle.cambioPlug = trampaDetalle[index].cambioPlug;
    _trampaDetalle.condicion = trampaDetalle[index].condicion;
    _trampaDetalle.especiePrincipal = trampaDetalle[index].especiePrincipal;
    _trampaDetalle.estadoFenologicoPrincipal =
        trampaDetalle[index].estadoFenologicoPrincipal;
    _trampaDetalle.especieColindante = trampaDetalle[index].especieColindante;
    _trampaDetalle.estadoFenologicoColindante =
        trampaDetalle[index].estadoFenologicoColindante;
    numeroEspecimenesTextController.text =
        trampaDetalle[index].numeroEspecimenes!.toString();
    _trampaDetalle.numeroEspecimenes = trampaDetalle[index].numeroEspecimenes;
    observacionTextController.text = trampaDetalle[index].observaciones ?? '';
    _trampaDetalle.observaciones = trampaDetalle[index].observaciones;
    _envioMuestra = trampaDetalle[index].envioMuestra!;
    _trampaDetalle.envioMuestra = trampaDetalle[index].envioMuestra;
  }

  TrampasMfSvModelo? get trampa => _trampa;

  TrampasMfSvDetalleModelo get detalleTrampa => _trampaDetalle;

  get cambioTrampa => _cambioTrampa;

  get cambioPlug => _cambioPlug;

  get envioMuestra => _envioMuestra;

  get esParroquia => Get.find<TrampeoMfSvLugarController>().esParroquia;

  set setTrampa(TrampasMfSvModelo trampa) => _trampa = trampa;

  set setCondicion(valor) => _trampaDetalle.condicion = valor;

  set setCambioTrampa(valor) {
    _cambioTrampa = valor;
    _trampaDetalle.cambioTrampa = valor;
    update(['idCambioTrampa']);
  }

  set setCambioPlug(valor) {
    _cambioPlug = valor;
    _trampaDetalle.cambioPlug = valor;
    update(['idCambioPlug']);
  }

  set setEspeciePrincipal(valor) => _trampaDetalle.especiePrincipal = valor;

  set setEstadoFenologicoPrincipal(valor) =>
      _trampaDetalle.estadoFenologicoPrincipal = valor;

  set setEspecieColindante(valor) => _trampaDetalle.especieColindante = valor;

  set setEstadoFenologicoColindante(valor) =>
      _trampaDetalle.estadoFenologicoColindante = valor;

  set setNumeroEspecimenes(valor) => _trampaDetalle.numeroEspecimenes = valor;

  set setEnvioMuestra(valor) {
    _trampaDetalle.envioMuestra = valor;
    _envioMuestra = valor;
    update(['idEnvioMuestra']);
  }

  set setObservacion(valor) => _trampaDetalle.observaciones = valor;

  void iniciarValidacion() {
    validandoBajada.value = true;
    mensajeBajarDatos.value = 'Almacenando...';
  }

  void finalizarValidacion(String mensaje) {
    validandoBajada.value = false;
    mensajeBajarDatos.value = mensaje;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (_trampaDetalle.condicion == null || _trampaDetalle.condicion == '') {
      errorCondicion = 'Campo requerido';
      esValido = false;
    } else {
      errorCondicion = null;
    }

    if (_trampaDetalle.especiePrincipal == null ||
        _trampaDetalle.especiePrincipal == '') {
      errorEspeciePrincipal = 'Campo requerido';
      esValido = false;
    } else {
      errorEspeciePrincipal = null;
    }

    if (_trampaDetalle.estadoFenologicoPrincipal == null ||
        _trampaDetalle.estadoFenologicoPrincipal == '') {
      errorFenologicoPrincipal = 'Campo requerido';
      esValido = false;
    } else {
      errorFenologicoPrincipal = null;
    }

    if (_trampaDetalle.especieColindante == null ||
        _trampaDetalle.especieColindante == '') {
      errorEspecieColindante = 'Campo requerido';
      esValido = false;
    } else {
      errorEspecieColindante = null;
    }

    if (_trampaDetalle.estadoFenologicoColindante == null ||
        _trampaDetalle.estadoFenologicoColindante == '') {
      errorFenologicoColindante = 'Campo requerido';
      esValido = false;
    } else {
      errorFenologicoColindante = null;
    }

    if (_trampaDetalle.numeroEspecimenes == null) {
      errorNumeroEspecimenes = 'Campo requerido';
      esValido = false;
    } else {
      errorNumeroEspecimenes = null;
    }

    if (_cambioTrampa == '') {
      sinCambioTrampa = true;
      esValido = false;
    } else {
      sinCambioTrampa = false;
    }

    if (_cambioPlug == '') {
      sinCambioPlug = true;
      esValido = false;
    } else {
      sinCambioPlug = false;
    }

    if (_envioMuestra == '') {
      sinEnvioMuestra = true;
      esValido = false;
    } else {
      sinEnvioMuestra = false;
    }

    update(
        ['idValidacion', 'idCambioTrampa', 'idCambioPlug', 'idEnvioMuestra']);

    return esValido;
  }

  guardarFormulario({
    required String titulo,
    required Widget mensaje,
    required Widget icono,
  }) async {
    iniciarValidacion();

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    Random random = Random();

    await Future.delayed(const Duration(seconds: 1));

    if (!estaLLenado) {
      UsuarioModelo? usuario = await _homeRepositorio.getUsuario();
      _trampaDetalle.idProvincia = _trampa!.idProvincia;
      _trampaDetalle.nombreProvincia = _trampa!.provincia;
      _trampaDetalle.idCanton = _trampa!.idCanton;
      _trampaDetalle.nombreCanton = _trampa!.canton;
      _trampaDetalle.idParroquia = _trampa!.idParroquia;
      _trampaDetalle.nombreParroquia = _trampa!.parroquia;
      _trampaDetalle.idLugarInstalacion = _trampa!.idLugarInstalacion;
      _trampaDetalle.nombreLugarInstalacion = _trampa!.nombreLugarInstalacion;
      _trampaDetalle.numeroLugarInstalacion = _trampa!.numeroLugarInstalacion;
      _trampaDetalle.idTipoAtrayente = _trampa!.idTipoAtrayente;
      _trampaDetalle.nombreTipoAtrayente = _trampa!.nombreTipoAtrayente;
      _trampaDetalle.tipoTrampa = _trampa!.nombreTipoTrampa;
      _trampaDetalle.codigoTrampa = _trampa!.codigoTrampa;
      _trampaDetalle.semana = int.parse(utils.semanaDelAnio());
      _trampaDetalle.coordenadaX = _trampa!.coordenadax;
      _trampaDetalle.coordenadaY = _trampa!.coordenaday;
      _trampaDetalle.coordenadaZ = _trampa!.coordenadaz;
      _trampaDetalle.fechaInstalacion =
          utils.fechaFormateada('yyyy-MM-dd', _trampa!.fechaInstalacion!);
      _trampaDetalle.estadoTrampa = _trampa!.estadoTrampa;
      _trampaDetalle.exposicion =
          utils.calcularDiasEntreFechas(_trampa?.fechaInspeccion);
      _trampaDetalle.estadoRegistro = 'COMPLETO';
      _trampaDetalle.fechaInspeccion = DateTime.now().toString();
      _trampaDetalle.usuarioId = usuario!.identificador;
      _trampaDetalle.idTablet = (random.nextInt(90) + 1);
      _trampaDetalle.usuario = usuario.nombre;
      _trampaDetalle.tabletVersionBase = SCHEMA_VERSION;
      _trampaDetalle.tabletId = usuario.identificador;

      ctrPrincipal.addTrampaDetalle(_trampaDetalle);

      final lsitaTrampasOriginales =
          Get.find<TrampeoMfSvTrampasController>().trampas;

      int index2 = 0;

      lsitaTrampasOriginales.asMap().forEach((i, value) {
        if (value.codigoTrampa == _trampa!.codigoTrampa!) {
          index2 = i;
        }
      });

      Get.find<TrampeoMfSvTrampasController>().actualizarCompletados(index2);
    } else {
      Get.find<TrampeoMfSvController>().actualizarTrampa(_trampaDetalle, index);
    }

    finalizarValidacion('Registros almacenados');

    await Future.delayed(const Duration(seconds: 1));
    Get.back();
    Get.back();
  }
}

import 'package:agro_servicios/app/data/models/registroInformacion/contaminanteModelo.dart';
import 'package:agro_servicios/app/data/models/registroInformacion/registroInformacionModelo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroInformacionController extends GetxController {
  var frontera = false.obs;

  String? errorPrograma;
  String? errorFechaMuestra;
  String? errorCodigoMuestra;
  String? errorNombreMuestra;
  String? errorTipoMuestra;
  String? errorProducto;
  String? errorOrigenMuestra;

  List<ContaminanteModelo> contaminantes = [
    ContaminanteModelo(
        id: 1,
        nombre: "COLIFORMES TOTALES",
        unidad: "UFC",
        resultado: "108",
        codex: "102–104",
        ue: "102–124",
        eeuu: "102–114",
        positivo: "+"),
    ContaminanteModelo(
        id: 2,
        nombre: "E.COLI",
        unidad: "UFC",
        resultado: "10.6",
        codex: "10–10.2",
        ue: "10–10.4",
        eeuu: "10–10.8",
        positivo: "+")
  ];

  var codigoMuestraCamTextController = TextEditingController();
  var nombreSitioTextController = TextEditingController();
  var codigoCentroFaenamientoTextController = TextEditingController();
  var certificadoZoosanitariaTextController = TextEditingController();
  var nombreRepresentanteLegTextController = TextEditingController();
  var paisProcedenciaTextController = TextEditingController();
  var numeroPermisoFitosanitarioTextController = TextEditingController();
  var razonSocialExportadorTextController = TextEditingController();
  var tipoMuestraTextController = TextEditingController();
  var numeroQuipuxTextController = TextEditingController();
  var fechaRecepcionTextController = TextEditingController();
  var fechaEmisionTextController = TextEditingController();
  var referenciaTextController = TextEditingController();
  var codigoMuestraLabTextController = TextEditingController();
  var accionesTomadasTextController = TextEditingController();
  var observacionesTextController = TextEditingController();
  var imagenesTextController = TextEditingController();

  RegistroInformacionModelo _registro = RegistroInformacionModelo(
      fechaEmision: new DateTime.now(), fechaRecepcion: new DateTime.now());

  RegistroInformacionModelo get registro => _registro;

  set setPrograma(valor) => _registro.programa = valor;
  set setFechaMuestra(valor) => _registro.fechaMuestra = valor;
  set setCodigoMuestraCam(valor) => _registro.codigoMuestraCam = valor;
  set setNombreMuestra(valor) => _registro.nombreMuestra = valor;
  set setOrigenMuestra(valor) => _registro.origenMuestra = valor;
  set setNombreSitio(valor) => _registro.nombreSitio = valor;
  set setCodigoCentroFaenamiento(valor) =>
      _registro.codigoCentroFaenamiento = valor;
  set setCertificadoZoosanitaria(valor) =>
      _registro.certificadoZoosanitaria = valor;
  set setNombreRepresentanteLeg(valor) =>
      _registro.nombreRepresentanteLeg = valor;
  set setPaisProcedencia(valor) => _registro.paisProcedencia = valor;
  set setNumeroPermisoFito(valor) =>
      _registro.numeroPermisoFitosanitario = valor;
  set setRazonSocialExportador(valor) =>
      _registro.razonSocialExportador = valor;
  set setTipoMuestra(valor) => _registro.tipoMuestra = valor;
  set setNumeroQuipux(valor) => _registro.numeroQuipux = valor;
  //set setFechaRecepcion(valor) => _registro.fechaRecepcion = valor;
  //set setFechaEmision(valor) => _registro.fechaEmision = valor;
  set setReferencia(valor) => _registro.referencia = valor;
  set setCodigoMuestraLab(valor) => _registro.codigoMuestraLab = valor;
  set setAccionesTomadas(valor) => _registro.accionesTomadas = valor;
  set setObservaciones(valor) => _registro.observaciones = valor;
  set setImagenes(valor) => _registro.imagenes = valor;

  // Hasta que funcione el catálogo
  set setIdProvincia(valor) => _registro.idProvincia = valor;
  set setIdCanton(valor) => _registro.idCanton = valor;
  set setIdParroquia(valor) => _registro.idParroquia = valor;

  bool validarFormulario() {
    bool _esValido = true;

    /*if (_registro.programa == null || _registro.programa == '') {
      errorPrograma = 'Campo requerido';
      _esValido = false;
    } else {
      errorPrograma = null;
    }

    if (_registro.fechaMuestra == null || _registro.fechaMuestra == '') {
      errorFechaMuestra = 'Campo requerido';
      _esValido = false;
    } else {
      errorFechaMuestra = null;
    }

    if (_registro.codigoMuestra == null || _registro.codigoMuestra == '') {
      errorCodigoMuestra = 'Campo requerido';
      _esValido = false;
    } else {
      errorCodigoMuestra = null;
    }

    if (_registro.nombreMuestra == null || _registro.nombreMuestra == '') {
      errorNombreMuestra = 'Campo requerido';
      _esValido = false;
    } else {
      errorNombreMuestra = null;
    }*/

    update([
      'idValidacion',
      'idCambioTrampa',
      'idCambioPlug',
      'idEnvioMuestra'
    ]); // Revisar

    return _esValido;
  }

  set setFrontera(bool valor) {
    this.frontera.value = valor;
    update();
  }

  set setFechaRecepcion(DateTime valor) {
    this._registro.fechaRecepcion = valor;
    update();
  }

  set setFechaEmision(DateTime valor) {
    this._registro.fechaEmision = valor;
    update();
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_sitio_modelo.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_form_sv_controller.dart';
import 'package:agro_servicios/app/modules/trips/controllers/trips_paso2_controller.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/utils/codigo_sv.dart';

///Controlador solo para manejar los tabs de Formulario
class TripsPaso1Controller extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final controlador = Get.find<TripsFormSvController>();

  RxList<String> listaProductor = <String>[].obs;

  List<TripsSitioModelo> listaAreasSelecionadas = [];
  List<TripsSitioModelo> listaSitios = [];
  List<TripsSitioModelo> listaTipoAreas = [];
  List<TripsSitioModelo> listaAreas = [];
  List listaAreasValores = [];
  List<RespuestasAreasModelo> listaAreasModelo = [];
  List<dynamic> seleccionados = [];
  String selecionados = '';

  RxString numeroReporteR = ''.obs;

  RxString provincia = ''.obs;
  RxString canton = ''.obs;
  RxString parroquia = ''.obs;

  String? errorRazonSocial;
  String? errorSitio;
  String? errorArea;
  String? errorTipoArea;

  @override
  void onReady() {
    getListaOperador();
    inicializaModeloPaso1();
    super.onReady();
  }

  get getRazon {
    if ((controlador.modelo.ruc == '' &&
            controlador.modelo.razonSocial == '') ||
        (controlador.modelo.ruc == null &&
            controlador.modelo.razonSocial == null)) {
      return '--';
    } else {
      return '${controlador.modelo.ruc} - ${controlador.modelo.razonSocial}';
    }
  }

  get getSitio {
    if (controlador.modelo.idSitioProduccion != null &&
        controlador.modelo.idSitioProduccion != '') {
      return int.parse(controlador.modelo.idSitioProduccion!);
    } else {
      return null;
    }
  }

  get getTipoArea {
    if (controlador.modelo.tipoArea != null) {
      return '${controlador.modelo.tipoArea}';
    } else {
      return null;
    }
  }

  setId(valor) => controlador.modelo.id = valor;
  setNumeroReporte(valor) => controlador.modelo.numeroReporte = valor;

  setRuc(valor) {
    controlador.modelo.ruc = valor;
    controlador.actualizarCampo('ruc', valor);
  }

  setRazonSocial(valor) {
    controlador.modelo.razonSocial = valor;
    controlador.actualizarCampo('razon_social', valor);
  }

  setProvincia(valor) {
    controlador.modelo.provincia = valor;
    controlador.actualizarCampo('provincia', valor);
  }

  setCanton(valor) {
    controlador.modelo.canton = valor;
    controlador.actualizarCampo('canton', valor);
  }

  setParroquia(valor) {
    controlador.modelo.parroquia = valor;
    controlador.actualizarCampo('parroquia', valor);
  }

  setIdSitioProduccion(valor) {
    controlador.modelo.idSitioProduccion = valor;
    controlador.actualizarCampo('id_sitio_produccion', valor);
  }

  setSitioProduccion(valor) {
    controlador.modelo.sitioProduccion = valor;
    controlador.actualizarCampo('sitio_produccion', valor);
  }

  setTotalAreas(valor) {
    controlador.modelo.totalAreas = valor;
    controlador.actualizarCampo('total_areas', valor);
  }

  setListaAreas(valor) {
    controlador.modelo.listaAreas = valor;
    controlador.actualizarCampo('lista_areas', valor);
  }

  setTipoArea(valor) {
    controlador.modelo.tipoArea = valor;
    controlador.actualizarCampo('tipo_area', valor);
  }

  setFechaIngresoGuia(valor) => controlador.modelo.fechaIngresoGuia = valor;

  ///Obtiene lista de Operadores, se carga una sola vez.
  Future<void> getListaOperador() async {
    limpiarDatos('Productor');
    List<TripsProductorModelo> poderes = await controlador.listaOperador();
    if (poderes.isNotEmpty) {
      for (var e in poderes) {
        String valorProductor =
            '${e.identificador.toString()} - ${e.nombre.toString()}';
        listaProductor.add(valorProductor);
      }
    }
    update(['ruc', 'sitio', 'tipo', 'areas', 'tabla']);
  }

  ///Obtiene la lista de Sitios relacionadas con el operador, cambia si el operador cambia
  Future<void> getListaSitio(productor) async {
    String cadena = productor.toString();
    var cadena1 = cadena.split(" - ");
    String identificador = cadena1[0];

    limpiarDatos('Sitio');
    listaSitios = await controlador.listaSitios(identificador);

    setRuc(identificador);
    setRazonSocial(cadena1[1]);
    // controlador.actualizarModelo();
    update(['sitio', 'tipo', 'areas', 'tabla']);
  }

  ///Obtiene la lista de Tipo de Areas relacionadas con el Sitio, cambia si el sitio cambia
  Future<void> getListaTipoArea(idsitio) async {
    limpiarDatos('TipoArea');
    listaTipoAreas =
        await controlador.listaTipoAreas(controlador.modelo.ruc, idsitio);

    TripsSitioModelo? modeloSitio = await controlador.modeloSitio(idsitio);

    setIdSitioProduccion(idsitio.toString());
    setSitioProduccion(modeloSitio?.sitio.toString());
    setProvincia(modeloSitio?.provincia.toString());
    setCanton(modeloSitio?.canton.toString());
    setParroquia(modeloSitio?.parroquia.toString());

    // controlador.actualizarModelo();
    update(['tipo', 'areas', 'tabla']);
  }

  ///Obtiene la lista de Areas relacionadas con el Tipo de Area, cambia si el tipo de area cambia
  Future<void> getListaArea(tipo) async {
    limpiarDatos('Area');
    listaAreas = await controlador.listaAreas(
        controlador.modelo.ruc, controlador.modelo.idSitioProduccion, tipo);

    setTipoArea(tipo.toString());
    // controlador.actualizarModelo();

    final controllerP2 = Get.find<TripsPaso2Controller>();
    controllerP2.seleccionaPreguntasTipArea();
    update(['areas', 'tabla']);
  }

  ///Obtiene la información de las Areas seleccionadas, cambia si el tipo de areas cambia
  Future<void> getBuscarUbicacionAreas(listAreaSelect) async {
    //Borra Areas

    controlador.deleteIdAreas(
        controlador.idFormulario, controlador.modelo.numeroReporte);
    listaAreasValores = listAreaSelect;
    cargarIdAreas(listAreaSelect);

    String? cadena = listAreaSelect
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll(" ", "");

    String areas = cadena;
    List<TripsSitioModelo> lista = await controlador.listaAreasSeleccionadas(
        controlador.modelo.ruc, controlador.modelo.idSitioProduccion, areas);
    setTotalAreas(lista.length);

    listaAreasSelecionadas = lista;

    update(['areas', 'tabla']);
  }

  ///Nuevo -Guarda las respuestas
  cargarIdAreas(listAreaSelect) {
    listAreaSelect.forEach((e) {
      RespuestasAreasModelo modeloArea = RespuestasAreasModelo();
      modeloArea.formulario = controlador.idFormulario;
      modeloArea.numeroReporte = controlador.modelo.numeroReporte;
      modeloArea.idArea = int.parse(e);
      controlador.saveIdAreasModelo(modeloArea);
    });
  }

  limpiarDatos(tipo) {
    switch (tipo) {
      case 'Productor':
        controlador.modelo.ruc = null;
        controlador.modelo.razonSocial = null;
        listaSitios = [];
        controlador.modelo.idSitioProduccion = null;
        controlador.modelo.sitioProduccion = null;
        listaTipoAreas = [];
        controlador.modelo.tipoArea = null;

        listaAreasSelecionadas = [];
        listaAreas = [];
        listaAreasValores = [];

        errorSitio = null;
        numeroReporteR.value = '';
        final controllerP2 = Get.find<TripsPaso2Controller>();
        controllerP2.limpiaPreguntas();
        controlador.modelo.observaciones = null;
        controlador.modelo.representante = null;
        break;
      case 'Sitio':
        listaSitios = [];
        controlador.modelo.idSitioProduccion = null;
        controlador.modelo.sitioProduccion = null;
        listaTipoAreas = [];
        controlador.modelo.tipoArea = null;
        listaAreasValores = [];
        listaAreasSelecionadas = [];
        listaAreas = [];

        errorSitio = null;
        errorTipoArea = null;
        errorArea = null;
        break;

      case 'TipoArea':
        listaTipoAreas = [];
        controlador.modelo.tipoArea = null;
        listaAreasValores = [];
        listaAreasSelecionadas = [];
        listaAreas = [];
        errorTipoArea = null;
        errorArea = null;
        break;
      case 'Area':
        listaAreasValores = [];
        listaAreasSelecionadas = [];
        listaAreas = [];
        controlador.modelo.observacionF09 = null;
        errorArea = null;
        break;

      default:
        break;
    }
    provincia.value = '';
    canton.value = '';
    parroquia.value = '';
  }

  //
  ///Inicializa el modelo con datos basicos en estado Incompleto y campos vacios
  inicializaModeloPaso1() async {
    String paso = await controlador.iniciaFormulario();
    if (paso == 'actualizar') {
      cargarModelo();
    } else if (paso == 'nuevo') {
      modeloNuevo();
    }
  }

  ///Inicializa el modelo con datos basicos en estado Incompleto y campos vacios
  cargarModelo() async {
    if (controlador.modelo.estadoF09 == 'En proceso...') {
      //Exite llenemos conforme su alcance
      numeroReporteR.value = controlador.modelo.numeroReporte.toString();
      if (controlador.modelo.ruc != '' && controlador.modelo.ruc != null) {
        listaSitios = await controlador.listaSitios(controlador.modelo.ruc);
      }

      if (controlador.modelo.sitioProduccion != "" &&
          controlador.modelo.sitioProduccion != null) {
        //carga Datos del Sitio
        listaTipoAreas = await controlador.listaTipoAreas(
            controlador.modelo.ruc, controlador.modelo.idSitioProduccion);
      }

      if (controlador.modelo.tipoArea != '' &&
          controlador.modelo.tipoArea != null) {
        listaAreas = await controlador.listaAreas(controlador.modelo.ruc,
            controlador.modelo.idSitioProduccion, controlador.modelo.tipoArea);
      }

      //Cargar ubicacion
      listaAreasModelo = await controlador.getIdAreasParaFormulario(
          controlador.idFormulario, controlador.modelo.numeroReporte);

      String areas = '';
      if (listaAreasModelo.isNotEmpty) {
        debugPrint('entro a buscar areas');
        for (var e in listaAreasModelo) {
          // provincia.value = listaAreasSelecionadas[0].provincia.toString();
          // canton.value = listaAreasSelecionadas[0].canton.toString();
          // parroquia.value = listaAreasSelecionadas[0].parroquia.toString();
          areas = '$areas,${e.idArea}';
          listaAreasValores.add(e.idArea.toString());
        }
        debugPrint(listaAreasValores.toString());

        areas = areas.substring(1, areas.length);
        List<TripsSitioModelo> lista =
            await controlador.listaAreasSeleccionadas(controlador.modelo.ruc,
                controlador.modelo.idSitioProduccion, areas);
        listaAreasSelecionadas = lista;
      }
      //Cargo Preguntas
      if (controlador.modelo.tipoArea != '' &&
          controlador.modelo.tipoArea != null) {
        final controllerP2 = Get.find<TripsPaso2Controller>();
        controllerP2.seleccionaPreguntasTipArea();
      }

      update(['ruc', 'sitio', 'tipo', 'areas', 'tabla']);
    }
  }

  modeloNuevo() async {
    UsuarioModelo? listaUsuario = UsuarioModelo();

    String fechaInspeccion = '';

    final fecha = DateTime.now().toString();
    fechaInspeccion = fecha.toString();
    String tabletVersionBase = BD_VERSION.toString();

    listaUsuario = await DBHomeProvider.db.getUsuario();
    String usuarioId = listaUsuario!.identificador.toString();
    String usuario = listaUsuario.nombre.toString();

    String tabletId = usuarioId;
    String? provinciaUs = await controlador.getProvinciaUs();

    var nr = generarCodigoSv(provincia: provinciaUs.toString());
    numeroReporteR.value = nr.toString();
    //No hay incompletos Nuevo
    int id = await controlador.getCodigo();
    controlador.modelo.id = id;
    controlador.modelo.idTablet = 0;

    controlador.modelo.numeroReporte = nr;
    controlador.modelo.ruc = '';
    controlador.modelo.razonSocial = '';
    controlador.modelo.provincia = '';
    controlador.modelo.canton = '';
    controlador.modelo.parroquia = '';
    controlador.modelo.idSitioProduccion = '';
    controlador.modelo.sitioProduccion = '';

    controlador.modelo.representante = '';
    controlador.modelo.resultado = '';
    controlador.modelo.observaciones = '';
    controlador.modelo.fechaInspeccion = fechaInspeccion;
    controlador.modelo.usuarioId = usuarioId;
    controlador.modelo.usuario = usuario;
    controlador.modelo.tabletId = tabletId;
    controlador.modelo.tabletVersionBase = tabletVersionBase;
    controlador.modelo.fechaIngresoGuia = '';
    controlador.modelo.estadoF09 = "En proceso...";
    controlador.modelo.observacionF09 = '';

    controlador.modelo.tipoArea = "";
    controlador.modelo.totalResultado = 0;
    controlador.modelo.totalAreas = 0;
    controlador.modelo.idPonderacion = 0;
    controlador.guardarModelo(controlador.modelo);
    // controlador.actualizarModelo();
  }

  bool get validaDatosFormulario {
    bool esValido = true;

    if (controlador.modelo.ruc == null || controlador.modelo.ruc == '') {
      errorRazonSocial = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorRazonSocial = null;
    }

    if (controlador.modelo.sitioProduccion == null ||
        controlador.modelo.sitioProduccion == '') {
      errorSitio = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorSitio = null;
    }
    if (controlador.modelo.tipoArea == null ||
        controlador.modelo.tipoArea == '') {
      errorTipoArea = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorTipoArea = null;
    }

    if (controlador.modelo.totalAreas == null ||
        controlador.modelo.totalAreas == 0) {
      errorArea = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorArea = null;
    }

    return esValido;
  }
}

import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/repository/trips_sv_repository.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_sitio_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsFormSvController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final tripsRepositorio = Get.find<TripsRepository>();

  TripsModelo modelo = TripsModelo();
  String idFormulario = 'APL_PRO_TRIPS';

  TabController? tabController;
  int index = 0;
  bool? verFab;
  String proceso = '';

  //Crea los Tabs par las 3 etapas de formulario
  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController!.animation!.addListener(cambioVistaTab);
    super.onInit();
  }

  //Función para cambiar de tab en tab
  void cambioVistaTab() {
    final aniValue = tabController!.animation!.value;

    if (aniValue >= 0.5) {
      if (index != 1) {
        index = 1;
        verFab = true;
        update(['fab']);
      }
      if (aniValue >= 1.5 && aniValue <= 2) {
        index = 2;
        verFab = true;
        update(['fab']);
      }
    } else if (aniValue <= 0.5 && index > 0) {
      if (index != 0) {
        index = 0;
        verFab = true;
        update(['fab']);
      }
    }
  }

//Respuestas
  Future<void> actualizarRespuestasModelo(idPregunta, dicotomia) async {
    tripsRepositorio.updateRespuestas(idPregunta, dicotomia);
  }

  Future<void> guardarRespuestasModelo(modeloR) async {
    tripsRepositorio.saveInspeccionModelo(modeloR);
  }

// Fin Respuestas
  Future<void> borrarModelo() async {
    final tripsRepositorio = Get.find<TripsRepository>();
    tripsRepositorio.deleteTodosInspecciones();
    tripsRepositorio.deleteTodosIdAreas(idFormulario);
    tripsRepositorio.deleteTodosRespuestas(idFormulario);

    update(['ver']);
  }

  Future<void> actualizarModelo() async {
    tripsRepositorio.updateTrips(modelo);
  }

  Future<void> actualizarCampo(campo, valor) async {
    tripsRepositorio.updateCampoTrips(modelo.id, campo, valor);
  }

  Future<void> guardarModelo(modeloR) async {
    tripsRepositorio.saveInspeccionModelo(modeloR);
  }

  Future<int> getCodigo() async {
    return tripsRepositorio.getCodigoInspeccion();
  }

  ///Diversas Consultas a DB
  ///Obtiene lista de Operadores, se carga una sola vez.
  Future<List<TripsProductorModelo>> listaOperador() async {
    List<TripsProductorModelo> lista =
        await tripsRepositorio.getProductorLista();
    return lista;
  }

  Future<List<TripsSitioModelo>> listaSitios(identificador) async {
    List<TripsSitioModelo> lista =
        await tripsRepositorio.getSitiosPorUsuario(identificador);
    return lista;
  }

  Future<List<TripsSitioModelo>> listaTipoAreas(ruc, idSitio) async {
    List<TripsSitioModelo> lista =
        await tripsRepositorio.getTipoAreaPorOpeSit(ruc, idSitio);
    return lista;
  }

  Future<String?> nombreSitio(idSitio) async {
    TripsSitioModelo? sitio = await tripsRepositorio.getSitioPorId(idSitio);
    String? nombreSitio = sitio?.sitio.toString();
    return nombreSitio;
  }

  Future<TripsSitioModelo?> modeloSitio(idSitio) async {
    TripsSitioModelo? sitio = await tripsRepositorio.getSitioPorId(idSitio);
    return sitio;
  }

  Future<List<TripsSitioModelo>> listaAreas(
      ruc, idSitioProduccion, tipo) async {
    List<TripsSitioModelo> lista = await tripsRepositorio.getAreaPorOpeSitTip(
        ruc, idSitioProduccion, tipo);
    return lista;
  }

  Future<List<TripsSitioModelo>> listaAreasSeleccionadas(
      ruc, idSitioProduccion, areas) async {
    List<TripsSitioModelo> lista = await tripsRepositorio.getUbicacionMultiple(
        ruc, idSitioProduccion, areas);

    return lista;
  }

  Future<String> iniciaFormulario() async {
    UsuarioModelo? listaUsuario = UsuarioModelo();
    listaUsuario = await DBHomeProvider.db.getUsuario();
    String usuarioId = listaUsuario!.identificador.toString();

    modelo =
        await tripsRepositorio.getTripsModeloEstado('En proceso...', usuarioId);

    if (modelo.estadoF09 == 'En proceso...') {
      //Exite llenemos conforme su alcance
      proceso = 'actualizar';
    } else {
      proceso = 'nuevo';
    }
    return proceso;
  }

  Future<String?> getProvinciaUs() async {
    ProvinciaUsuarioContratoModelo? provinciaModelo =
        await tripsRepositorio.obtenerProvinciaContrato();
    return provinciaModelo?.provincia!;
  }
  //Preguntas

  Future<List<PreguntasModelo>> getPreguntasParaFormulario(
      idFormulario, tipoArea) async {
    List<PreguntasModelo> lista = await tripsRepositorio
        .getPreguntasParaFormulario(idFormulario, tipoArea);
    return lista;
  }

  Future<List<RespuestasModelo>> getRespuestas(
      idFormulario, numeroReporte) async {
    List<RespuestasModelo> lista = await tripsRepositorio
        .getRespuestasParaFormulario(idFormulario, numeroReporte);
    return lista;
  }

  Future<void> deleteRespuestas(idFormulario, numeroReporte) async {
    final tripsRepositorio = Get.find<TripsRepository>();
    tripsRepositorio.deleteRespuestas(idFormulario, numeroReporte);
    update(['ver']);
  }

  Future<void> saveRespuesta(modeloRespuesta) async {
    tripsRepositorio.saveRespuestasModelo(modeloRespuesta);
  }

  Future<int> getRespuestasPositivas(idFormulario, numeroReporte) async {
    int total = await tripsRepositorio.getRespuestasPositivas(
        idFormulario, numeroReporte);
    return total;
  }

  //Fin Preguntas

  //Areas
  Future<List<RespuestasAreasModelo>> getIdAreasParaFormulario(
      idFormulario, numeroReporte) async {
    List<RespuestasAreasModelo> lista = await tripsRepositorio
        .getIdAreasParaFormulario(idFormulario, numeroReporte);
    return lista;
  }

  Future<void> deleteIdAreas(idFormulario, numeroReporte) async {
    final tripsRepositorio = Get.find<TripsRepository>();
    tripsRepositorio.deleteIdAreas(idFormulario, numeroReporte);
    update(['ver']);
  }

  Future<void> saveIdAreasModelo(modeloRespuesta) async {
    tripsRepositorio.saveAreasModelo(modeloRespuesta);
  }
  //Fin Areas

}

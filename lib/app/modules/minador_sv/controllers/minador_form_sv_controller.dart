import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/repository/minador_sv_repository.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_sitio_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinadorFormSvController extends GetxController
    with ControladorBase, GetSingleTickerProviderStateMixin {
  final minadorRepositorio = Get.find<MinadorRepository>();

  MinadorModelo modelo = MinadorModelo();
  String idFormulario = 'APL_PRO_MINADOR';

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
    minadorRepositorio.updateRespuestas(idPregunta, dicotomia);
  }

  Future<void> guardarRespuestasModelo(modeloR) async {
    minadorRepositorio.saveInspeccionModelo(modeloR);
  }

// Fin Respuestas
  Future<void> borrarModelo() async {
    final minadorRepositorio = Get.find<MinadorRepository>();
    minadorRepositorio.deleteTodosInspecciones();
    minadorRepositorio.deleteTodosIdAreas(idFormulario);
    minadorRepositorio.deleteTodosRespuestas(idFormulario);

    update(['ver']);
  }

  Future<void> actualizarModelo() async {
    minadorRepositorio.updateMinador(modelo);
  }

  Future<void> actualizarCampo(campo, valor) async {
    minadorRepositorio.updateCampoMinador(modelo.id, campo, valor);
  }

  Future<void> guardarModelo(modeloR) async {
    minadorRepositorio.saveInspeccionModelo(modeloR);
  }

  Future<int> getCodigo() async {
    return minadorRepositorio.getCodigoInspeccion();
  }

  ///Diversas Consultas a DB
  ///Obtiene lista de Operadores, se carga una sola vez.
  Future<List<MinadorProductorModelo>> listaOperador() async {
    List<MinadorProductorModelo> lista =
        await minadorRepositorio.getProductorLista();
    return lista;
  }

  Future<List<MinadorSitioModelo>> listaSitios(identificador) async {
    List<MinadorSitioModelo> lista =
        await minadorRepositorio.getSitiosPorUsuario(identificador);
    return lista;
  }

  Future<List<MinadorSitioModelo>> listaTipoAreas(ruc, idSitio) async {
    List<MinadorSitioModelo> lista =
        await minadorRepositorio.getTipoAreaPorOpeSit(ruc, idSitio);
    return lista;
  }

  Future<String?> nombreSitio(idSitio) async {
    MinadorSitioModelo? sitio = await minadorRepositorio.getSitioPorId(idSitio);
    String? nombreSitio = sitio?.sitio.toString();
    return nombreSitio;
  }

  Future<MinadorSitioModelo?> modeloSitio(idSitio) async {
    MinadorSitioModelo? sitio = await minadorRepositorio.getSitioPorId(idSitio);
    return sitio;
  }

  Future<List<MinadorSitioModelo>> listaAreas(
      ruc, idSitioProduccion, tipo) async {
    List<MinadorSitioModelo> lista = await minadorRepositorio
        .getAreaPorOpeSitTip(ruc, idSitioProduccion, tipo);
    return lista;
  }

  Future<List<MinadorSitioModelo>> listaAreasSeleccionadas(
      ruc, idSitioProduccion, areas) async {
    List<MinadorSitioModelo> lista = await minadorRepositorio
        .getUbicacionMultiple(ruc, idSitioProduccion, areas);

    return lista;
  }

  Future<String> iniciaFormulario() async {
    UsuarioModelo? listaUsuario = UsuarioModelo();
    listaUsuario = await DBHomeProvider.db.getUsuario();
    String usuarioId = listaUsuario!.identificador.toString();

    modelo = await minadorRepositorio.getMinadorModeloEstado(
        'En proceso...', usuarioId);

    if (modelo.estadoF08 == 'En proceso...') {
      //Exite llenemos conforme su alcance
      proceso = 'actualizar';
    } else {
      proceso = 'nuevo';
    }
    return proceso;
  }

  Future<String?> getProvinciaUs() async {
    ProvinciaUsuarioContratoModelo? provinciaModelo =
        await minadorRepositorio.obtenerProvinciaContrato();
    return provinciaModelo?.provincia!;
  }
  //Preguntas

  Future<List<PreguntasModelo>> getPreguntasParaFormulario(
      idFormulario, tipoArea) async {
    List<PreguntasModelo> lista = await minadorRepositorio
        .getPreguntasParaFormulario(idFormulario, tipoArea);
    return lista;
  }

  Future<List<RespuestasModelo>> getRespuestas(
      idFormulario, numeroReporte) async {
    List<RespuestasModelo> lista = await minadorRepositorio
        .getRespuestasParaFormulario(idFormulario, numeroReporte);
    return lista;
  }

  Future<void> deleteRespuestas(idFormulario, numeroReporte) async {
    final minadorRepositorio = Get.find<MinadorRepository>();
    minadorRepositorio.deleteRespuestas(idFormulario, numeroReporte);
    update(['ver']);
  }

  Future<void> saveRespuesta(modeloRespuesta) async {
    minadorRepositorio.saveRespuestasModelo(modeloRespuesta);
  }

  Future<int> getRespuestasPositivas(idFormulario, numeroReporte) async {
    int total = await minadorRepositorio.getRespuestasPositivas(
        idFormulario, numeroReporte);
    return total;
  }

  //Fin Preguntas

  //Areas
  Future<List<RespuestasAreasModelo>> getIdAreasParaFormulario(
      idFormulario, numeroReporte) async {
    List<RespuestasAreasModelo> lista = await minadorRepositorio
        .getIdAreasParaFormulario(idFormulario, numeroReporte);
    return lista;
  }

  Future<void> deleteIdAreas(idFormulario, numeroReporte) async {
    final minadorRepositorio = Get.find<MinadorRepository>();
    minadorRepositorio.deleteIdAreas(idFormulario, numeroReporte);
    update(['ver']);
  }

  Future<void> saveIdAreasModelo(modeloRespuesta) async {
    minadorRepositorio.saveAreasModelo(modeloRespuesta);
  }
  //Fin Areas

}

import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/ponderacion_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/minador_sv/minador_sitio_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_respuestas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_minador_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/minador_sv_provider.dart';
import 'package:get/get.dart';

class MinadorRepository {
  final _minadorProvider = Get.find<MinadorProvider>();
  final _dbMinadorProvider = Get.find<DBMinadorProvider>();
  final _loginProvider = Get.find<LoginProvider>();

  final _localizacionDbProvider = Get.find<DBLocalizacionProvider>();
  final _dbUathProvider = Get.find<DBUathProvider>();

  //Preguntas
  final _dbPreguntasProvider = Get.find<DBPreguntasProvider>();
  final _dbPonderacionProvider = Get.find<DBPonderacionProvider>();
  final _preguntasProvider = Get.find<PreguntasProvider>();
  final _ponderacionProvider = Get.find<PonderacionProvider>();
  //Respuestas
  final _dbRespuestasProvider = Get.find<DBRespuestasProvider>();
  //Usuario Id

  /// Devuelve una consulta de la base local de los sitios, de los Productor
  /// devuelve:Lista de Productor
  Future<List<MinadorProductorModelo>> getProductorLista() async =>
      _dbMinadorProvider.obtenerListaMinadorProductorModelo();

  /// Devuelve una consulta de la base local de los sitios,
  /// segun el identificador del Productor
  /// recibe:identificador
  /// devuelve:Lista de Sitios
  Future<List<String>> getSitioIdLista(identificador) async =>
      _dbMinadorProvider.obtenerSitioLista(identificador);

  /// Ubicacion Controler
  Future<List<MinadorSitioModelo>> getAreaPorOpeSitTip(
          idProductor, idSitio, tipoArea) async =>
      _dbMinadorProvider.obteneAreaPorOpeSitTip(idProductor, idSitio, tipoArea);

  /// Ubicacion Controler
  Future<List<MinadorSitioModelo>> getTipoAreaPorOpeSit(
          idProductor, idSitio) async =>
      _dbMinadorProvider.obteneTipoAreaPorOpeSit(idProductor, idSitio);

  /// Obtiene el sitio por id de sitio
  ///
  /// Retorna un modelo [MinadorSitioModelo]
  Future<MinadorSitioModelo?> getSitioPorId(int idSitio) async =>
      _dbMinadorProvider.obtenerSitioPorId(idSitio);

  /// Devuelve una consulta de la base local de el area seleccionada,
  /// segun el identificador y el id del area
  /// recibe:identificador,id_area
  /// devuelve:Lista del Sitio
  Future<List<MinadorSitioModelo>> getUbicacion(
          identificador, idsitio, idarea) async =>
      _dbMinadorProvider.obtenerUbicacion(identificador, idsitio, idarea);

  Future<List<MinadorSitioModelo>> getUbicacionMultiple(
          identificador, idsitio, idAreas) async =>
      _dbMinadorProvider.obtenerUbicacionMultiple(
          identificador, idsitio, idAreas);

  Future<MinadorSitioModelo?> getUbicacionModelo(
          identificador, idsitio, idarea) async =>
      _dbMinadorProvider.obtenerUbicacionModelo(identificador, idsitio, idarea);

  //***New */
  Future<List<MinadorSitioModelo>> getSitiosPorUsuario(identificador) async =>
      _dbMinadorProvider.obtenerSitiosPorUsuario(identificador);
  //***New */

  //nuevoInspeccion
  Future<void> saveInspeccionModelo(MinadorModelo modelo) async =>
      _dbMinadorProvider.nuevoInspeccion(modelo);
  //nuevoInspeccion
  Future<int> getCodigoInspeccion() async =>
      _dbMinadorProvider.codigoInspeccion();

  ///Revisar las actualizaciones
  Future<void> updateMinador(MinadorModelo modelo) async =>
      _dbMinadorProvider.actualizaMinador(modelo);

  ///Revisar las actualizaciones
  Future<void> updateCampoMinador(id, campo, valor) async =>
      _dbMinadorProvider.actualizaCampoMinador(id, campo, valor);

  ///Revisar las actualizaciones
  Future<void> updateMinadorEstado(MinadorModelo modelo) async =>
      _dbMinadorProvider.actualizarMinadorEstado(modelo);

//Fin Formulario
  Future<ProvinciaUsuarioContratoModelo?> obtenerProvinciaContrato() async =>
      _dbUathProvider.getProvinciaContrato();

  Future<List<LocalizacionModelo>> getProvincias() async =>
      _localizacionDbProvider.getLocalizacionPorCategoria(1);

  ///Crea tablas
  // Future<void> createTablesMinadorCatalago() async =>
  //     await _dbMinadorProvider.creaTablasMinadorCatalogo();

  ///Eliminar Sitio
  Future<void> deleteSitioCatalogo() async =>
      await _dbMinadorProvider.eliminarTodosSitios();

  ///Eliminar Productor
  Future<void> deleteProductoCatalago() async =>
      await _dbMinadorProvider.eliminarTodosProductos();

  ///Eliminar Productor
  Future<void> deletePreguntasCatalogo() async =>
      await _dbMinadorProvider.eliminarTodasPreguntas();

  Future<void> deleteTodosInspecciones() async =>
      await _dbMinadorProvider.eliminarTodosInspecciones();

  Future<void> deleteInspeccionesIncompleta() async =>
      await _dbMinadorProvider.eliminarInspeccionesIncompleta();

  ///Obtiene el Catalogo de Productor de MinadorProvider
  Future<List<MinadorProductorModelo>> getProductorCatalogo(String provincia) {
    return _minadorProvider.obtenerProductorCatalogo(
        provincia, _loginProvider.obtenerToken());
  }

  /// Obtiene el Catalogo de Productor de DBMinadorProvider
  Future<MinadorProductorModelo?> getProductorModelo() async =>
      _dbMinadorProvider.obtenerTodosProductor();

  ///Llama a Guarda el Modelo Productor de DBMinadorProvider
  Future<void> saveProductorModelo(MinadorProductorModelo modelo) async =>
      _dbMinadorProvider.nuevoProducto(modelo);

  ///Obtiene el Catalogo de Sitios de MinadorProvider
  Future<List<MinadorSitioModelo>> getSitioCatalogo(String provincia) {
    return _minadorProvider.obtenerSitioCatalogo(
        provincia, _loginProvider.obtenerToken());
  }

  /// Obtiene el Catalogo de Sitio de DBMinadorProvider
  Future<MinadorSitioModelo?> getSitioModelo() async =>
      _dbMinadorProvider.obtenerTodosSitio();
  /*
  * Preguntas y Ponderacion
  */

  Future<List<PreguntasModelo>> getPreguntas(idFormulario) {
    return _preguntasProvider.obtenerPreguntasCatalogo(
        _loginProvider.obtenerToken(), idFormulario);
  }

  Future<List<PreguntasModelo>> getPreguntasParaFormulario(
      idFormulario, tipoArea) {
    return _dbPreguntasProvider.obtenerPreguntas(idFormulario, tipoArea);
  }

  Future<List<PonderacionModelo>> getPonderacion(idFormulario) {
    return _ponderacionProvider.obtenerPonderacionCatalogo(
        _loginProvider.obtenerToken(), idFormulario);
  }

  Future<List<PonderacionModelo>> getPonderacionParaFormulario(
      idFormulario, String tipoArea) {
    return _dbPonderacionProvider.obtenerPonderacion(idFormulario, tipoArea);
  }

  Future<void> deletePreguntasSvCatalogo(idFormulario) async =>
      await _dbPreguntasProvider.eliminarTodosPreguntas(idFormulario);

  Future<void> deletePonderacionSvCatalogo(codAplicacion) async =>
      await _dbPonderacionProvider.eliminarTodosPonderacion(codAplicacion);

  Future<void> savePonderacionModelo(PonderacionModelo modelo) async =>
      _dbPonderacionProvider.nuevoPonderacion(modelo);

  Future<void> savePreguntasModelo(PreguntasModelo modelo) async =>
      _dbPreguntasProvider.nuevoPreguntas(modelo);

  Future<PreguntasModelo?> getPreguntaSvModelo() async =>
      _dbPreguntasProvider.obtenerPreguntasSvModelo();

  Future<PonderacionModelo?> getPonderacionSvModelo() async =>
      _dbPonderacionProvider.obtenerPonderacionSvModelo();

  /*
  * Fin Preguntas y Ponderacion
  */

  ///Guarda el Modelo Productor de DBMinadorProvider
  Future<void> saveSitioModelo(MinadorSitioModelo modelo) async =>
      _dbMinadorProvider.nuevoSitio(modelo);

  ///Obtiene el modelo de Inspecciones
  Future<List<MinadorModelo>> getMinadorModeloLista(usuarioId) async =>
      _dbMinadorProvider.obtenerTodosInspeccionesLista(usuarioId);

  Future<MinadorModelo?> getMinadorModelo(estado, usuarioId) async =>
      _dbMinadorProvider.obtenerInspeccionEstado(estado, usuarioId);

  Future<MinadorModelo?> getMinadorModeloA() async =>
      _dbMinadorProvider.obtenerMinadorModelo();

  ///Obtiene el modelo de Inspecciones
  Future<MinadorModelo> getMinadorModeloEstado(estado, usuarioId) async =>
      _dbMinadorProvider.obtenerInspeccionEstado(estado, usuarioId);

  Future<List<MinadorModelo>> getMinadorListaCompleto(idFormulario) async {
    List<MinadorModelo> list =
        await _dbMinadorProvider.obtenerMinadorListaCompleto();
    return list;
  }

  //Sube el modelo al sistema guía
  Future saveUpMinador(modelo) {
    return _minadorProvider.sincronizacionSubir(
        modelo, _loginProvider.obtenerToken());
  }

/**
 * Fin Sincronizar
 * 
 */

/**
 * Respuestas
 * 
 */
  ///nuevoInspeccion
  Future<void> saveRespuestasModelo(RespuestasModelo modelo) async =>
      _dbRespuestasProvider.nuevoRespuestas(modelo);

  ///Revisar las actualizaciones
  Future<void> updateRespuestas(idPregunta, dicotomia) async =>
      _dbRespuestasProvider.actualizaRespuestas(idPregunta, dicotomia);

  Future<void> deleteRespuestas(idFormulario, numeroReporte) async =>
      await _dbRespuestasProvider.eliminarRespuestas(
          idFormulario, numeroReporte);

  Future<List<RespuestasModelo>> getRespuestasParaFormulario(
      idFormulario, numeroReporte) {
    return _dbRespuestasProvider.obtenerRespuestas(idFormulario, numeroReporte);
  }

  Future<void> deleteTodosRespuestas(formulario) async =>
      await _dbRespuestasProvider.eliminarTodasRespuestas(formulario);

  Future<void> deleteTodasIdAreas(formulario) {
    return _dbRespuestasProvider.eliminarTodasIdAreas(formulario);
  }

  Future<int> getRespuestasPositivas(idFormulario, numeroReporte) {
    return _dbRespuestasProvider.obtenerRespuestasPositivas(
        idFormulario, numeroReporte);
  }

  Future<void> deleteIdAreas(idFormulario, numeroReporte) async =>
      await _dbRespuestasProvider.eliminarAreas(idFormulario, numeroReporte);
/* Fin Respuestas */

/* Areas */

  Future<List<RespuestasAreasModelo>> getIdAreasParaFormulario(
      idFormulario, numeroReporte) {
    return _dbRespuestasProvider.obtenerAreas(idFormulario, numeroReporte);
  }

  Future<void> saveAreasModelo(RespuestasAreasModelo modelo) async =>
      _dbRespuestasProvider.nuevoAreas(modelo);

  Future<void> deleteTodosIdAreas(formulario) async =>
      await _dbRespuestasProvider.eliminarTodasIdAreas(formulario);
/**
 * Fin Areas
 * 
 */

}

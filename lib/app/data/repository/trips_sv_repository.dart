import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_areas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/respuestas_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/ponderacion_modelo.dart';
import 'package:agro_servicios/app/data/models/preguntas_sv/preguntas_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_productor_modelo.dart';
import 'package:agro_servicios/app/data/models/trips_sv/trips_sitio_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_respuestas_sv.dart';
import 'package:agro_servicios/app/data/provider/local/db_trips_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/ponderacion_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/preguntas_sv.dart';
import 'package:agro_servicios/app/data/provider/ws/trips_sv_provider.dart';
import 'package:get/get.dart';

class TripsRepository {
  final _tripsProvider = Get.find<TripsProvider>();
  final _dbTripsProvider = Get.find<DBTripsProvider>();
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
  Future<List<TripsProductorModelo>> getProductorLista() async =>
      _dbTripsProvider.obtenerListaTripsProductorModelo();

  /// Devuelve una consulta de la base local de los sitios,
  /// segun el identificador del Productor
  /// recibe:identificador
  /// devuelve:Lista de Sitios
  Future<List<String>> getSitioIdLista(identificador) async =>
      _dbTripsProvider.obtenerSitioLista(identificador);

  /// Ubicacion Controler
  Future<List<TripsSitioModelo>> getAreaPorOpeSitTip(
          idProductor, idSitio, tipoArea) async =>
      _dbTripsProvider.obteneAreaPorOpeSitTip(idProductor, idSitio, tipoArea);

  /// Ubicacion Controler
  Future<List<TripsSitioModelo>> getTipoAreaPorOpeSit(
          idProductor, idSitio) async =>
      _dbTripsProvider.obteneTipoAreaPorOpeSit(idProductor, idSitio);

  /// Obtiene el sitio por id de sitio
  ///
  /// Retorna un modelo [TripsSitioModelo]
  Future<TripsSitioModelo?> getSitioPorId(int idSitio) async =>
      _dbTripsProvider.obtenerSitioPorId(idSitio);

  /// Devuelve una consulta de la base local de el area seleccionada,
  /// segun el identificador y el id del area
  /// recibe:identificador,id_area
  /// devuelve:Lista del Sitio
  Future<List<TripsSitioModelo>> getUbicacion(
          identificador, idsitio, idarea) async =>
      _dbTripsProvider.obtenerUbicacion(identificador, idsitio, idarea);

  Future<List<TripsSitioModelo>> getUbicacionMultiple(
          identificador, idsitio, idAreas) async =>
      _dbTripsProvider.obtenerUbicacionMultiple(
          identificador, idsitio, idAreas);

  Future<TripsSitioModelo?> getUbicacionModelo(
          identificador, idsitio, idarea) async =>
      _dbTripsProvider.obtenerUbicacionModelo(identificador, idsitio, idarea);

  //***New */
  Future<List<TripsSitioModelo>> getSitiosPorUsuario(identificador) async =>
      _dbTripsProvider.obtenerSitiosPorUsuario(identificador);
  //***New */

  //nuevoInspeccion
  Future<void> saveInspeccionModelo(TripsModelo modelo) async =>
      _dbTripsProvider.nuevoInspeccion(modelo);
  //nuevoInspeccion
  Future<int> getCodigoInspeccion() async =>
      _dbTripsProvider.codigoInspeccion();

  ///Revisar las actualizaciones
  Future<void> updateTrips(TripsModelo modelo) async =>
      _dbTripsProvider.actualizaTrips(modelo);

  ///Revisar las actualizaciones
  Future<void> updateCampoTrips(id, campo, valor) async =>
      _dbTripsProvider.actualizaCampoTrips(id, campo, valor);

  ///Revisar las actualizaciones
  Future<void> updateTripsEstado(TripsModelo modelo) async =>
      _dbTripsProvider.actualizarTripsEstado(modelo);

//Fin Formulario
  Future<ProvinciaUsuarioContratoModelo?> obtenerProvinciaContrato() async =>
      _dbUathProvider.getProvinciaContrato();

  Future<List<LocalizacionModelo>> getProvincias() async =>
      _localizacionDbProvider.getLocalizacionPorCategoria(1);

  ///Crea tablas
  // Future<void> createTablesTripsCatalago() async =>
  //     await _dbTripsProvider.creaTablasTripsCatalogo();

  ///Eliminar Sitio
  Future<void> deleteSitioCatalogo() async =>
      await _dbTripsProvider.eliminarTodosSitios();

  ///Eliminar Productor
  Future<void> deleteProductoCatalago() async =>
      await _dbTripsProvider.eliminarTodosProductos();

  ///Eliminar Productor
  Future<void> deletePreguntasCatalogo() async =>
      await _dbTripsProvider.eliminarTodasPreguntas();

  Future<void> deleteTodosInspecciones() async =>
      await _dbTripsProvider.eliminarTodosInspecciones();

  Future<void> deleteInspeccionesIncompleta() async =>
      await _dbTripsProvider.eliminarInspeccionesIncompleta();

  ///Obtiene el Catalogo de Productor de TripsProvider
  Future<List<TripsProductorModelo>> getProductorCatalogo(String provincia) {
    return _tripsProvider.obtenerProductorCatalogo(
        provincia, _loginProvider.obtenerToken());
  }

  /// Obtiene el Catalogo de Productor de DBTripsProvider
  Future<TripsProductorModelo?> getProductorModelo() async =>
      _dbTripsProvider.obtenerTodosProductor();

  ///Llama a Guarda el Modelo Productor de DBTripsProvider
  Future<void> saveProductorModelo(TripsProductorModelo modelo) async =>
      _dbTripsProvider.nuevoProducto(modelo);

  ///Obtiene el Catalogo de Sitios de TripsProvider
  Future<List<TripsSitioModelo>> getSitioCatalogo(String provincia) {
    return _tripsProvider.obtenerSitioCatalogo(
        provincia, _loginProvider.obtenerToken());
  }

  /// Obtiene el Catalogo de Sitio de DBTripsProvider
  Future<TripsSitioModelo?> getSitioModelo() async =>
      _dbTripsProvider.obtenerTodosSitio();
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

  ///Guarda el Modelo Productor de DBTripsProvider
  Future<void> saveSitioModelo(TripsSitioModelo modelo) async =>
      _dbTripsProvider.nuevoSitio(modelo);

  ///Obtiene el modelo de Inspecciones
  Future<List<TripsModelo>> getTripsModeloLista(usuarioId) async =>
      _dbTripsProvider.obtenerTodosInspeccionesLista(usuarioId);

  Future<TripsModelo?> getTripsModelo(estado, usuarioId) async =>
      _dbTripsProvider.obtenerInspeccionEstado(estado, usuarioId);

  Future<TripsModelo?> getTripsModeloA() async =>
      _dbTripsProvider.obtenerTripsModelo();

  ///Obtiene el modelo de Inspecciones
  Future<TripsModelo> getTripsModeloEstado(estado, usuarioId) async =>
      _dbTripsProvider.obtenerInspeccionEstado(estado, usuarioId);

  Future<List<TripsModelo>> getTripsListaCompleto(idFormulario) async {
    List<TripsModelo> list = await _dbTripsProvider.obtenerTripsListaCompleto();
    return list;
  }

  //Sube el modelo al sistema guía
  Future saveUpTrips(modelo) {
    return _tripsProvider.sincronizacionSubir(
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

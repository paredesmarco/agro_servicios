import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_laboratorio_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/embalaje_control_sv/embalaje_control_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_embalaje_control_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/uath_provider.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_lugar_inspeccion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_puertos_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/embalaje_control_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/puertos_provider.dart';

class EmbalajeControlSvRepository {
  final _embalajeProvider = Get.find<EmbalajeControlProvider>();
  final _loginProvider = Get.find<LoginProvider>();
  final _puertosProvider = Get.find<PuertosProvider>();
  final _localizacionProvider = Get.find<LocalizacionProvider>();
  final _uathProvider = Get.find<UathProvider>();
  final _dbLugarInspeccionProvider = Get.find<DBLugarInspeccionProvider>();
  final _dbPuertosProvider = Get.find<DBPuertosProvider>();
  final _dbLocalizacionProvider = Get.find<DBLocalizacionProvider>();
  final _dbEmbalajeProvider = Get.find<DBEmbalajeControlSvProvider>();
  final _dbHomeProvider = Get.find<DBHomeProvider>();
  final _dbUath = Get.find<DBUathProvider>();

  // Servicios Web

  /// Obtener el catálogo de los puertos de carga de ingreso y salida desde el Sistema GUIA
  ///
  /// Retorna una lista del objeto [PuertosCatalogoModelo]
  Future<List<PuertosCatalogoModelo>> getPuertos() async =>
      await _puertosProvider
          .obtenerCatalogoPuertos(_loginProvider.obtenerToken());

  ///
  ///Obtiene la provincia donde esta creado el contrato del usuario en el Sistema GUIA
  ///
  Future<ProvinciaUsuarioContratoModelo> getUbicacionContrato(
          String identificador) async =>
      await _uathProvider.obtenerUbicacionContrato(
          identificador, _loginProvider.obtenerToken());

  /// Obtener la lista de países dese el Sistema GUIA
  ///
  /// Retorna una lista del objeto [LocalizacionCatalogo]
  Future<List<LocalizacionCatalogo>> getPaises() async =>
      await _localizacionProvider.obtenerLocalizacionPorcategoria(
          0, _loginProvider.obtenerToken());

  ///sicroniza al Sistema GUIA los registros de inspección de embalaje de madera
  Future sincronizarUp(Map<String, dynamic> embalaje) async =>
      await _embalajeProvider.sincronizarUp(
          embalaje, _loginProvider.obtenerToken());

  // Locales

  /*
   * Inserts
   */

  ///
  /// Recibe un objeto [PuertosCatalogoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarPuerto(PuertosCatalogoModelo puertos) async =>
      await _dbPuertosProvider.guardarPuertos(puertos);

  ///
  /// Recibe un objeto [PuertosCatalogoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarLugarInspeccion(LugarInspeccion lugar) async =>
      await _dbLugarInspeccionProvider.guardarLugarInspeccion(lugar);

  ///
  /// Recibe un objeto [LocalizacionCatalogo] para ser almacenado en DB local
  ///
  Future<void> guardarPais(LocalizacionCatalogo localizacion) async =>
      await _dbLocalizacionProvider.guardarLocalizacionCatalogo(localizacion);

  ///
  /// Recibe un objeto [ProvinciaUsuarioContratoModelo] para ser almacenado en DB local
  ///
  Future<void> guardarProvinciaContrato(
          ProvinciaUsuarioContratoModelo provincia) async =>
      await _dbUath.guardarProvinciaContrato(provincia);

  ///
  /// Recibe un objeto [EmbalajeControlModelo] para ser almacenado en DB local
  ///
  Future<int> guardarRegistroEmbalaje(EmbalajeControlModelo embalaje) async =>
      await _dbEmbalajeProvider.guardarRegistrosEmbalaje(embalaje);

  ///
  /// Recibe un objeto [EmbalajeControlLaboratorioSvModelo] para ser almacenado en DB local
  ///
  Future<int> guardarRegistroLaboratorioEmbalaje(
          EmbalajeControlLaboratorioSvModelo laboratorio) async =>
      await _dbEmbalajeProvider.guardarRegistrosLaboratorio(laboratorio);

  /*
   * Deletes
   */

  ///
  /// Elimina todos los registros de los puertos almacenados en DB local
  ///
  Future<void> eliminarPuertos() async =>
      await _dbPuertosProvider.eliminarPuertos();

  ///
  /// Elimina todos los registros de los puertos almacenados en DB local
  ///
  Future<void> eliminarLugarInspeccion() async =>
      await _dbLugarInspeccionProvider.eliminarLugarInspeccion();

  ///
  /// Elimina todos los registros de las inspecciones de embalaje de madera en DB local
  ///
  Future<void> eliminarRegistrosEmbalaje() async =>
      await _dbEmbalajeProvider.eliminarRegistrosEmbalaje();

  /// Elimina todos los ordenes de laboratorio que se generar
  /// de las inspecciones de embalaje de madera en DB local
  ///
  Future<void> eliminarOrdenesLaboratorio() async =>
      await _dbEmbalajeProvider.eliminarRegistrosOrdenLaboratorio();

  ///
  /// Elimina la provincia del contrato activo del usuario interno
  ///
  Future<void> eliminarProvinciaContrato() async =>
      await _dbUath.eliminarProvinciaContrato();

  /*
   * Selects
   */

  /// Obtener el catálogo de los puertos sincronizados localmente en la DB local
  ///
  /// Retorna una lista del objeto [PuertosCatalogoModelo]
  Future<List<PuertosCatalogoModelo>> getCatalogoPuertos() async =>
      await _dbPuertosProvider.getCatalogoPuertos();

  /// Obtener un puerto fitrado por id_puerto
  ///
  /// Retorna un objeto [PuertosCatalogoModelo]
  Future<PuertosCatalogoModelo?> getPuerto(int idPuerto) async =>
      await _dbPuertosProvider.getPuertoPorId(idPuerto);

  /// Obtener el catálogo de los lugares de inspección guardados en DB local, filtrado por el puerto
  ///
  /// Retorna una lista del objeto [LugarInspeccion]
  Future<List<LugarInspeccion>> getLugaresInspeccion(int idPuerto) async =>
      await _dbLugarInspeccionProvider.getLugarInspeccionPorId(idPuerto);

  /// Obtener el catálogo de localización por categoría
  ///
  /// Retorna una lista del objeto [LocalizacionModelo]
  Future<List<LocalizacionModelo>> getLocalizacionPorCategoria(
          int idPuerto) async =>
      await _dbLocalizacionProvider.getLocalizacionPorCategoria(idPuerto);

  /// Obtener una localizacion por su nombre
  ///
  /// Retorna un objeto [LocalizacionModelo]
  Future<LocalizacionModelo?> getLocalizacionPorNombre(String pais) async =>
      await _dbLocalizacionProvider.getLocalizacionPorNombre(pais);

  /// Obtener el secuencial de la tabla control_f03
  ///
  /// donde se guardan los registros de embalaje realizados en campo
  Future getCantidadRegistros() async =>
      await _dbEmbalajeProvider.getCantidadEmbalaje();

  /// Obtener el secuencial de la tabla control_f03
  ///
  /// donde se guardan los registros de embalaje realizados en campo
  Future getSecuenciaEmbalaje() async =>
      await _dbEmbalajeProvider.getSecuenciaEmbalaje();

  /// Obtener el secuencial de la tabla control_f03_orden
  ///
  /// donde se guardan los registros de orden de laboratorio de embalaje realizados en campo
  Future getSecuenciaLaboratorio() async =>
      await _dbEmbalajeProvider.getSecuenciaLaboratorio();

  /// Obtener el usuario logueado
  ///
  /// Retorna una lista del objeto [UsuarioModelo]
  Future<UsuarioModelo?> getsusuario() async =>
      await _dbHomeProvider.getUsuario();

  /// Obtener todas las inspecciones realizadas por el usuario
  ///
  /// Retorna una lista del objeto [EmbalajeControlModelo]
  Future<List<EmbalajeControlModelo>> getInspecciones() async =>
      await _dbEmbalajeProvider.getInspecciones();

  /// Obtener todas las ordenes de laboratorio generadas en inspecciones realizadas por el usuario
  ///
  /// Retorna una lista del objeto [EmbalajeControlLaboratorioSvModelo]
  Future<List<EmbalajeControlLaboratorioSvModelo>>
      getOrdenesLaboratorio() async =>
          await _dbEmbalajeProvider.getOrdenesLaboratorio();

  /// Obtener la provincia del contrato activo del usuario
  ///
  /// Retorna una lista del objeto [ProvinciaUsuarioContratoModelo]
  Future<ProvinciaUsuarioContratoModelo?> getProvinciaContrato() async =>
      await _dbUath.getProvinciaContrato();
}

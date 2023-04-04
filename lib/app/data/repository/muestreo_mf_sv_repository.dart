import 'package:agro_servicios/app/data/models/catalogos/provincia_usuario_contrato_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_laboratorio_modelo.dart';
import 'package:agro_servicios/app/data/models/muestreo_mosca_sv/muestreo_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_muestreo_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_uath_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/muestreo_mf_sv_provider.dart';
import 'package:get/get.dart';

class MuestreoMfSvRepository {
  final MuestreoMfSvProvider _muestreoProvider =
      Get.find<MuestreoMfSvProvider>();

  final DBMuestreoMfSvProvider _dbProvider = Get.find<DBMuestreoMfSvProvider>();
  final DBLocalizacionProvider _dbProviderLocalizacion =
      Get.find<DBLocalizacionProvider>();
  final DBHomeProvider _dbHome = Get.find<DBHomeProvider>();
  final DBUathProvider _dbuaht = Get.find<DBUathProvider>();

  final LocalizacionProvider _localizacionProvider =
      Get.find<LocalizacionProvider>();

  final LoginProvider _loginProvider = Get.find<LoginProvider>();

  /**
   * selects
   */

  ///Retorna el catálogo de localización por provización
  ///
  ///Dato de retorno List[LocalizacionModelo]
  getTodasProvincias() async =>
      await _dbProviderLocalizacion.getLocalizacionPorCategoria(1);

  ///Retorna el catálogo de localización por provización del servicio web
  ///
  ///Dato de retorno List[LocalizacionCatalogo]
  getCatalogoLocalizacion(int localizacion) async => await _localizacionProvider
      .obtenerCatalogoLocalizacion(localizacion, _loginProvider.obtenerToken());

  ///Retorna la provincia sincronizada
  ///
  ///Dato de retorno LocalizacionModelo
  getProvinciaSincronizada() async =>
      await _dbProvider.getProvinciaSincronizada();

  ///Retorna cantones sincronizados por el id del padre
  ///
  ///Dato de retorno List< LocalizacionModelo >
  getCanton(int provincia) async =>
      await _dbProviderLocalizacion.getLocalizacionPorPadre(provincia);

  ///Retorna parroquias sincronizados por el id del padre
  ///
  ///Dato de retorno List< LocalizacionModelo >
  getParroquia(int provincia) async =>
      await _dbProviderLocalizacion.getLocalizacionPorPadre(provincia);

  ///Retorna la localizacion por id
  ///
  ///Dato de retorno LocalizacionModelo
  getLocalizacion(int localizacion) async =>
      await _dbProviderLocalizacion.getLocalizacionPorId(localizacion);

  ///Retorna el total de registros de muestreos
  ///
  ///Dato de retorno int
  getCantidadMuestreo() async => await _dbProvider.getCantidadMuestras();

  ///Retorna el usuario logueado
  ///
  ///Dato de retorno UsuarioModelo
  getUsuario() async => await _dbHome.getUsuario();

  ///Retorna las muestras almacenadas
  ///
  ///Dato de retorno List < MuestreoMfSvModelo >
  getMuesteoTodos() async => await _dbProvider.getMuestreoTodos();

  ///Retorna las muestras de laboratorio almacenadas
  ///
  ///Dato de retorno List < MuestreoMfSvLaboratorioModeo >
  getLaboratoriosTodos() async =>
      await _dbProvider.getOrdenesLaboratorioTodos();

  ///Retorna la provincia del contrato del usuario
  ///
  ///Dato de retorno Future<ProvinciaUsuarioContratoModelo?>
  Future<ProvinciaUsuarioContratoModelo?> getProvinciaContrato() async =>
      await _dbuaht.getProvinciaContrato();

  /**
   * inserts
   */

  ///Guarda el catálogo (cantones y parroquias) de una provincia.
  guardarLocalizacionCatalogo(LocalizacionCatalogo localizacion) async {
    await _dbProviderLocalizacion.guardarLocalizacionCatalogo(localizacion);
  }

  ///Guarda la provincia de donde se sincroniza el catálogo de localización
  guardarProvinciaSincronizada(LocalizacionCatalogo localizacion) async {
    await _dbProvider.guardarProvinciaSincronizada(localizacion);
  }

  ///Guarda la provincia de donde se sincroniza el catálogo de localización
  guardarMuestreo(MuestreoMfSvModelo muestreo,
      List<MuestreoMfSvLaboratorioModeo> laboratorio) async {
    await _dbProvider.guardarMuestreo(muestreo, laboratorio);
  }

  ///sicroniza los muestreos con cabecera y detalle
  sincronizarUp(Map<String, dynamic> muestreo) async {
    return await _muestreoProvider.sincronizarUp(
        muestreo, _loginProvider.obtenerToken());
  }

  /**
  * Deletes
  */

  ///Eliminar la provincia sincronizada
  eliminarProvinciaSincronizada() async {
    await _dbProvider.eliminarProvinciaSincronizada();
  }

  ///Eliminar todaos los muestreos
  eliminarMuestreo() async {
    await _dbProvider.eliminarMuestreo();
  }

  ///Eliminar todaos las ordenes de laboratorio
  eliminarOrdenesLaboratorio() async {
    await _dbProvider.eliminarOrdenesLaboratorio();
  }
}

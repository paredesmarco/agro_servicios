import 'package:agro_servicios/app/data/models/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/provider/ws/caracterizacion_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_home_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion.dart';
import 'package:agro_servicios/app/data/provider/local/db_localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/local/db_caracterizacion_fr_mf_sv_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/localizacion_provider.dart';
import 'package:agro_servicios/app/data/provider/ws/login_provider.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvRepository {
  // final DBLocalizcion _dbLocalizacion = Get.find<DBLocalizcion>();

  final DBCaracterizacionFrMfSvProvider _dbProvider =
      Get.find<DBCaracterizacionFrMfSvProvider>();

  final DBLocalizacionProvider _dbProviderLocalizacion =
      Get.find<DBLocalizacionProvider>();

  final DBHomeProvider _dbHome = Get.find<DBHomeProvider>();

  final CaracterizacionFrMfSvProvider _caracterizacionProvider =
      Get.find<CaracterizacionFrMfSvProvider>();

  final LoginProvider _loginProvider = Get.find<LoginProvider>();

  final LocalizacionProvider _localizacionProvider =
      Get.find<LocalizacionProvider>();

  ///Retorna el catálogo de localización por provización
  ///
  ///Dato de retorno List < LocalizacionModelo >
  getTodasProvincias() async =>
      await _caracterizacionProvider.obtenerTodasProvincia();

  ///Retorna el total de registros realizados de caracterización frutícula
  ///
  ///Dato de retorno int
  getCantidadCaracterizacion() async =>
      await _dbProvider.getCantidadCaracterizacion();

  ///Retorna los cantones sincronizados por provincia
  ///
  ///Dato de retorno List < LocalizacionModelo >
  Future<List<LocalizacionModelo>> getCantones(int provincia) async {
    return await DBLocalizcion.db.getLocalizacionPorPadre(provincia);
  }

  ///Retorna la provincia sincronizada
  ///
  ///Dato de retorno LocalizacionModelo
  getProvinciaSincronizada() async =>
      await _dbProvider.getProvinciaSincronizada();

  ///
  ///Retorna el catálogo de localización por provización desde el webservice
  ///
  ///Dato de retorno List < LocalizacionCatalogo >
  getCatalogoLocalizacion(int localizacion) async {
    return await _localizacionProvider.obtenerCatalogoLocalizacion(
        localizacion, _loginProvider.obtenerToken());
  }

  ///Retorna la localizacion por id
  ///
  ///Dato de retorno LocalizacionModelo
  getLocalizacion(int localizacion) async =>
      await _dbProviderLocalizacion.getLocalizacionPorId(localizacion);

  ///Retorna las muestras almacenadas
  ///
  ///Dato de retorno List < MuestreoMfSvModelo >
  getCaracterizacionTodos() async =>
      await _dbProvider.getCaracterizacionTodos();

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

  ///Retorna el usuario logueado
  ///
  ///Dato de retorno UsuarioModelo
  getUsuario() async => await _dbHome.getUsuario();

  ///Guarda el catálogo (cantones y parroquias) de una provincia.
  guardarLocalizacionCatalogo(LocalizacionCatalogo localizacion) async {
    await _dbProviderLocalizacion.guardarLocalizacionCatalogo(localizacion);
  }

  ///Guarda la provincia de donde se sincroniza el catálogo de localización
  guardarProvinciaSincronizada(LocalizacionCatalogo localizacion) async {
    await _dbProvider.guardarProvinciaSincronizada(localizacion);
  }

  ///Guarda los registros de caracterización frutícula localmente
  guardarCaracterizacion(CaracterizacionFrMfSvModelo caracterizacion) async {
    await _dbProvider.guardarCaracterizacion(caracterizacion);
  }

  ///sicroniza los registros de caracterización frutícula
  sincronizarUp(Map<String, dynamic> caracterizacion) async {
    return await _caracterizacionProvider.sincronizarUp(
        caracterizacion, _loginProvider.obtenerToken());
  }

  ///Eliminar todaos los registros de caracterización frutícula
  eliminarCaracterizacion() async {
    await _dbProvider.eliminarCaracterizacion();
  }

  ///Eliminar la provincia sincronizada
  eliminarProvinciaSincronizada() async {
    await _dbProvider.eliminarProvinciaSincronizada();
  }
}

import 'dart:developer';
import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/trampeo_mosca_sv/trampas_mf_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/trampeo_mf_sv_repository.dart';

class TrampeoMfSvLugarController extends GetxController {
  @override
  void onReady() {
    obtenerProvinciasSincronizadas();
    super.onReady();
  }

  List provincia = [];
  List<LocalizacionModelo?> cantones = [];
  List lugar = [];
  List numeroInstalacion = [];
  List parroquia = [];

  int? idProvincia;
  int idCanton = 0;
  int idLugarInstalacion = 0;
  int idParroquia = 0;
  int idNumeroInstalacion = 0;

  bool esParroquia = false;

  final TrampeoMfSvRepository _trampeoRepository =
      Get.find<TrampeoMfSvRepository>();

  set setParroquia(int parroquia) {
    idParroquia = parroquia;
    idNumeroInstalacion = 0;
  }

  set setNumeroInstalacion(int numero) {
    idNumeroInstalacion = numero;
    idParroquia = 0;
  }

  void obtenerProvinciasSincronizadas() async {
    provincia = await _trampeoRepository.getTodasProvinciasSincronizadas();
    idParroquia = 0;
    idNumeroInstalacion = 0;
    esParroquia = false;
    idProvincia = null;
    update(['provincia']);
  }

  void obtenerCantonesPorProvinciasSincronizadas(int provincia) async {
    cantones = await _trampeoRepository.getCantonPorProvincia(provincia);
    idParroquia = 0;
    idNumeroInstalacion = 0;
    esParroquia = false;
    lugar = [];
    parroquia = [];
    numeroInstalacion = [];
    update(['canton', 'lugar', 'esParroquia', 'parroquia', 'numeroLugar']);
  }

  void obtenerLugarInstalacion(int canton) async {
    lugar = await _trampeoRepository.getLugarInstalacion(canton);
    idCanton = canton;
    parroquia = [];
    numeroInstalacion = [];
    update(['lugar', 'esParroquia', 'parroquia', 'numeroLugar']);
  }

  void verificarLugarInstalacion(int idLugar) async {
    idLugarInstalacion = idLugar;
    idParroquia = 0;
    idNumeroInstalacion = 0;
    if (idLugar != 0) {
      // this._parroquiaInstalacion = 0;
      // this._numeroLugarInstalacion = 0;
      TrampasMfSvModelo? lugar;
      lugar =
          await _trampeoRepository.getNombreLugarInstalacion(idCanton, idLugar);

      if (lugar!.nombreLugarInstalacion == 'Sitio de producción') {
        esParroquia = true;
        // update(['esParroquia']);

        await obtenerParroquiaInstalacion();
      } else {
        esParroquia = false;
        // update(['esParroquia']);

        await obtenerNumeroInstalacion();
      }
      update(['esParroquia']);
    } else {
      // limpiarDesdeNumeroYParroquia();
    }
  }

  Future<void> obtenerNumeroInstalacion() async {
    log('entro a build numero');
    numeroInstalacion = await _trampeoRepository.getNumeroLugarInstalacion(
        idCanton, idLugarInstalacion);
    // numeroInstalacion.forEach((e) => print('$e'));
    update(['numero']);
  }

  Future<void> obtenerParroquiaInstalacion() async {
    parroquia = await _trampeoRepository.getParroquiaInstalacion(
        idCanton, idLugarInstalacion);
    update(['parroquia']);
  }

  bool validarFormulario() {
    bool esValido = true;
    if (idCanton == 0) esValido = false;
    if (esParroquia) {
      if (idParroquia == 0) esValido = false;
    } else {
      if (idNumeroInstalacion == 0) esValido = false;
    }

    return esValido;
  }

  void encerarLugarTrampeo() async {
    idParroquia = 0;
    idNumeroInstalacion = 0;
    esParroquia = false;
    lugar = [];
    parroquia = [];
    // cantones = [];
    numeroInstalacion = [];
    provincia = [];
    idProvincia = null;
    // update(['provincia']);
    update([
      'provincia',
      'canton',
      'lugar',
      'esParroquia',
      'parroquia',
      'numeroLugar'
    ]);
    provincia = await _trampeoRepository.getTodasProvinciasSincronizadas();
    // obtenerProvinciasSincronizadas();
  }
}

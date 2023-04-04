import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/repository/embalaje_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/controllers/embalaje_control_sv_controller.dart';
import 'package:get/get.dart';

class EmbalajeLugarInspeccionControlSvController extends GetxController {
  final _repositorio = Get.find<EmbalajeControlSvRepository>();
  final _controlador = Get.find<EmbalajeControlSvController>();

  RxList<PuertosCatalogoModelo> puertos = <PuertosCatalogoModelo>[].obs;
  RxList<LugarInspeccion> lugaresInspeccion = <LugarInspeccion>[].obs;
  RxList<LocalizacionModelo> paises = <LocalizacionModelo>[].obs;

  String? valueAreaInspeccion;

  String? errorPuntoControl;
  String? errorAreaInspeccion;
  String? errorIndetidadEmbalaje;
  String? errorPaisOrigen;
  String? errorNumeroEmbalaje;
  String? errorNumeroUnidades;

  @override
  void onReady() {
    getCatalogoPuertos();
    getCatalogoPais(0);
    _controlador.embalajeModelo.envioMuestra = 'No';

    super.onReady();
  }

  set puntoControl(valor) =>
      _controlador.embalajeModelo.idPuntoControl = valor.toString();

  set areaInspeccion(valor) =>
      _controlador.embalajeModelo.areaInspeccion = valor;

  set identidadEmbalaje(valor) =>
      _controlador.embalajeModelo.identidadEmbalaje = valor;

  set paisOrigen(valor) {
    _controlador.embalajeModelo.paisOrigen = valor;
    getNombrePais(valor);
  }

  set numeroEmbalajes(valor) =>
      _controlador.embalajeModelo.numeroEmbalajes = valor;

  set numeroUnidades(valor) =>
      _controlador.embalajeModelo.numeroUnidades = valor;

  Future<void> getCatalogoPuertos() async {
    final List<PuertosCatalogoModelo> res =
        await _repositorio.getCatalogoPuertos();

    puertos.value = res;
  }

  Future<void> getCatalogLugaresInspeccion(int idPuerto) async {
    final List<LugarInspeccion> res =
        await _repositorio.getLugaresInspeccion(idPuerto);
    valueAreaInspeccion = null;
    lugaresInspeccion.value = res;
    _controlador.embalajeModelo.areaInspeccion = null;

    final PuertosCatalogoModelo? puerto =
        await _repositorio.getPuerto(idPuerto);

    _controlador.embalajeModelo.puntoControl = puerto?.nombre;
  }

  Future<void> getCatalogoPais(int idPuerto) async {
    final List<LocalizacionModelo> res =
        await _repositorio.getLocalizacionPorCategoria(idPuerto);
    paises.value = res;
  }

  Future<void> getNombrePais(String pais) async {
    final LocalizacionModelo? res =
        await _repositorio.getLocalizacionPorNombre(pais);

    _controlador.embalajeModelo.idPaisOrigen = res?.idGuia.toString();
  }

  bool validarFormulario() {
    bool esValido = true;
    if (_controlador.embalajeModelo.idPuntoControl == null) {
      errorPuntoControl = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorPuntoControl = null;
    }

    if (_controlador.embalajeModelo.areaInspeccion == null ||
        _controlador.embalajeModelo.areaInspeccion == '') {
      errorAreaInspeccion = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorAreaInspeccion = null;
    }

    if (_controlador.embalajeModelo.identidadEmbalaje == null ||
        _controlador.embalajeModelo.identidadEmbalaje == '') {
      errorIndetidadEmbalaje = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorIndetidadEmbalaje = null;
    }

    if (_controlador.embalajeModelo.paisOrigen == null ||
        _controlador.embalajeModelo.paisOrigen == '') {
      errorPaisOrigen = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorPaisOrigen = null;
    }

    if (_controlador.embalajeModelo.numeroEmbalajes == null) {
      errorNumeroEmbalaje = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorNumeroEmbalaje = null;
    }

    if (_controlador.embalajeModelo.numeroUnidades == null) {
      errorNumeroUnidades = CAMPO_REQUERIDO;
      esValido = false;
    } else {
      errorNumeroUnidades = null;
    }

    update([
      'idPuntoControl',
      'idAreaInspeccion',
      'idIdentidad',
      'idPaisOrigen',
      'idNumeroEmbalaje',
      'idNumeroInspeccion'
    ]);

    return esValido;
  }
}

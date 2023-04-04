import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_solicitud_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/seguimiento_cuarentenario_sv_repository.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:get/get.dart';

class SeguimientoCuarentenarioPaso1SvController extends GetxController {
  final _seguimientoRespository =
      Get.find<SeguimientoCuarentenarioSvRepository>();

  final _controlador = Get.find<SeguimientoCuarentenarioSvController>();

  SeguimientoCuarentenarioSolicitudSvModelo? solicitud;
  RxList<LocalizacionModelo> listaProvincias = <LocalizacionModelo>[].obs;
  RxList<LocalizacionModelo> listaCantones = <LocalizacionModelo>[].obs;
  RxList<LocalizacionModelo> listaParroquias = <LocalizacionModelo>[].obs;
  RxList<SeguimientoCuarentenarioAreaCuarentenaSvModelo> listaAreas =
      <SeguimientoCuarentenarioAreaCuarentenaSvModelo>[].obs;

  String? errorProvincia;
  String? errorCanton;
  String? errorParroquia;
  String? errorNombreScpe;
  String? errorTipoOperacion;
  String? errorTipoCuarentena;
  String? errorFaseSeguimiento;
  String? errorCodigoLote;

  String prueba = '';

  @override
  void onInit() {
    solicitud = Get.arguments;
    llenarDatosOperador(solicitud);
    super.onInit();
  }

  @override
  void onReady() async {
    obtenerListaProvincia();
    super.onReady();
  }

  // set nombreScpe(valor) => _controlador.seguimientoModelo.nombreScpe = valor;

  set tipoOperacion(valor) =>
      _controlador.seguimientoModelo.tipoOperacion = valor;

  set tipoCuarentena(valor) =>
      _controlador.seguimientoModelo.tipoCuarentenaCondicionProduccion = valor;

  set faseSeguimiento(valor) =>
      _controlador.seguimientoModelo.faseSeguimiento = valor;

  get canton => _controlador.seguimientoModelo.codigoCanton;

  get parroquia => _controlador.seguimientoModelo.codigoParroquia;

  void llenarDatosOperador(
      SeguimientoCuarentenarioSolicitudSvModelo? solicitud) {
    _controlador.seguimientoModelo.idSeguimientoCuarentenario =
        solicitud?.idSeguimientoCuarentenario;

    _controlador.seguimientoModelo.rucOperador =
        solicitud?.identificadorOperador;

    _controlador.seguimientoModelo.razonSocial = solicitud?.razonSocial;

    _controlador.seguimientoModelo.codigoPaisOrigen = solicitud?.idPaisOrigen;

    _controlador.seguimientoModelo.paisOrigen = solicitud?.paisOrigen;

    _controlador.seguimientoModelo.producto =
        solicitud?.solicitudProductos?[0].producto;

    _controlador.seguimientoModelo.subtipo =
        solicitud?.solicitudProductos?[0].subtipo;

    _controlador.seguimientoModelo.peso =
        solicitud?.solicitudProductos?[0].peso.toString();

    _controlador.seguimientoModelo.numeroPlantasIngreso =
        solicitud?.numeroPlantasIngreso;

    _controlador.seguimientoModelo.numeroSeguimientosPlanificados =
        solicitud?.numeroSeguimientosPlanificados;

    _controlador.seguimientoModelo.codigoLote = solicitud?.idVue;

    obtenerAreasCuarentena(solicitud!.identificadorOperador!);
  }

  Future<void> obtenerAreasCuarentena(String identificador) async {
    final res = await _seguimientoRespository
        .getSolicitudesAreasCuarentenaSincronizados(identificador);
    listaAreas.value = res;
  }

  Future<void> obtenerListaProvincia() async {
    final res = await _seguimientoRespository.getLocalizacionPorCategoria(1);

    listaProvincias.value = res;
    listaCantones.value = [];
    _controlador.seguimientoModelo.codigoCanton = null;
    _controlador.seguimientoModelo.codigoParroquia = null;
  }

  Future<void> obtenerListaCantones(int idProvicnia) async {
    final res =
        await _seguimientoRespository.getLocalizacionPorIdPadre(idProvicnia);

    listaCantones.value = res;
    listaParroquias.value = [];
    _controlador.seguimientoModelo.codigoCanton = null;
    _controlador.seguimientoModelo.codigoParroquia = null;
  }

  Future<void> obtenerListaParroquias(int idProvicnia) async {
    final res =
        await _seguimientoRespository.getLocalizacionPorIdPadre(idProvicnia);

    listaParroquias.value = res;
    _controlador.seguimientoModelo.codigoParroquia = null;
  }

  Future<void> obtenerAreaCuarentena(int id) async {
    final res =
        await _seguimientoRespository.getSolicitudeAreasCuarentenaPorId(id);

    _controlador.seguimientoModelo.nombreScpe = res?.nombreLugar;
  }

  Future<void> setProvincia(int idProvincia) async {
    _controlador.seguimientoModelo.codigoProvincia = idProvincia;

    final res = await _seguimientoRespository.getLocalizacionPorId(idProvincia);

    final LocalizacionModelo? provincia = res;

    _controlador.seguimientoModelo.provincia = provincia?.nombre;
  }

  Future<void> setCanton(int idCanton) async {
    _controlador.seguimientoModelo.codigoCanton = idCanton;

    final res = await _seguimientoRespository.getLocalizacionPorId(idCanton);

    final LocalizacionModelo? canton = res;

    _controlador.seguimientoModelo.canton = canton?.nombre;
  }

  Future<void> setParroquia(int idParroquia) async {
    _controlador.seguimientoModelo.codigoParroquia = idParroquia;

    final res = await _seguimientoRespository.getLocalizacionPorId(idParroquia);

    final LocalizacionModelo? parroquia = res;

    _controlador.seguimientoModelo.parroquia = parroquia?.nombre;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (_controlador.seguimientoModelo.provincia == null) {
      esValido = false;
      errorProvincia = CAMPO_REQUERIDO;
    } else {
      errorProvincia = null;
    }

    if (_controlador.seguimientoModelo.canton == null) {
      esValido = false;
      errorCanton = CAMPO_REQUERIDO;
    } else {
      errorCanton = null;
    }

    if (_controlador.seguimientoModelo.parroquia == null) {
      esValido = false;
      errorParroquia = CAMPO_REQUERIDO;
    } else {
      errorParroquia = null;
    }

    if (_controlador.seguimientoModelo.nombreScpe == null ||
        _controlador.seguimientoModelo.nombreScpe == '') {
      esValido = false;
      errorNombreScpe = CAMPO_REQUERIDO;
    } else {
      errorNombreScpe = null;
    }

    if (_controlador.seguimientoModelo.tipoOperacion == null) {
      esValido = false;
      errorTipoOperacion = CAMPO_REQUERIDO;
    } else {
      errorTipoOperacion = null;
    }

    if (_controlador.seguimientoModelo.tipoCuarentenaCondicionProduccion ==
        null) {
      esValido = false;
      errorTipoCuarentena = CAMPO_REQUERIDO;
    } else {
      errorTipoCuarentena = null;
    }

    if (_controlador.seguimientoModelo.faseSeguimiento == null) {
      esValido = false;
      errorFaseSeguimiento = CAMPO_REQUERIDO;
    } else {
      errorFaseSeguimiento = null;
    }

    if (_controlador.seguimientoModelo.codigoLote == null ||
        _controlador.seguimientoModelo.codigoLote == '') {
      esValido = false;
      errorCodigoLote = CAMPO_REQUERIDO;
    } else {
      errorCodigoLote = null;
    }

    update(['idValidacion']);

    return esValido;
  }
}

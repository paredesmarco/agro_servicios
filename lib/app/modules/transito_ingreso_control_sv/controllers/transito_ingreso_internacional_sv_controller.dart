import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/catalogos/paises_origen_procedencia_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/puertos_catalogo_modelo.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/repository/transito_ingreso_control_sv_repository.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/controllers/transito_ingreso_control_sv_controller.dart';

class TransitoIngresoInternacionalControlSvController extends GetxController {
  final _repositorio = Get.find<TransitoIngresoControlSvRepository>();
  final _controlador = Get.find<TransitoIngresoControlSvController>();

  RxList<PaisesOrigenProcedenciaModelo> listaPaisOrigen =
      <PaisesOrigenProcedenciaModelo>[].obs;
  RxList<PaisesOrigenProcedenciaModelo> listaPaisProcedencia =
      <PaisesOrigenProcedenciaModelo>[].obs;
  RxList<LocalizacionModelo> listaPaisesCatalogo = <LocalizacionModelo>[].obs;
  RxList<PuertosCatalogoModelo> listaPuertosIngreso =
      <PuertosCatalogoModelo>[].obs;
  RxList<PuertosCatalogoModelo> listaPuertosSalida =
      <PuertosCatalogoModelo>[].obs;

  String? errorPaisOrigen;
  String? errorPaisProcedencia;
  String? errorPaisDestino;
  String? errorPuntoIngreso;
  String? errorPuntoSalida;
  String? errorPlacaVehiculo;
  String? errorDDA;
  String? errorPrecinto;

  @override
  void onReady() {
    getPaisesOrigenProcedencia();
    getPaisesCatalogo();
    getPuertos();
    super.onReady();
  }

  set paisOrigen(valor) {
    _controlador.ingresoModelo.paisOrigen = valor;
    _getPaisOrigen(valor);
  }

  set paisProcedencia(valor) {
    _controlador.ingresoModelo.paisProcedencia = valor;
    _getPaisProcedencia(valor);
  }

  set paisDestino(valor) {
    _controlador.ingresoModelo.paisDestino = valor;
    _getPaisDestino(valor);
  }

  set puntoIngreso(valor) {
    _controlador.ingresoModelo.puntoIngreso = valor;
    _getPuntoIngreso(valor);
  }

  set puntoSalida(valor) {
    _controlador.ingresoModelo.puntoSalida = valor;
    _getPuntoSalida(valor);
  }

  set placaVehiculo(valor) => _controlador.ingresoModelo.placaVehiculo = valor;

  set dda(valor) => _controlador.ingresoModelo.dda = valor;

  set precinto(valor) => _controlador.ingresoModelo.precintoSticker = valor;

  Future<void> getPaisesOrigenProcedencia() async {
    final List<PaisesOrigenProcedenciaModelo> res =
        await _repositorio.getCatalogoPaisOrigenProcedencia();

    listaPaisOrigen.value = res;
    listaPaisProcedencia.value = res;
  }

  Future<void> getPaisesCatalogo() async {
    final List<LocalizacionModelo> res = await _repositorio.getPaisCatalogo(0);

    listaPaisesCatalogo.value = res;
  }

  Future<void> getPuertos() async {
    final List<PuertosCatalogoModelo> res =
        await _repositorio.getPuertosSincronizados();

    listaPuertosIngreso.value = res;
    listaPuertosSalida.value = res;
  }

  Future<void> _getPaisOrigen(String nombre) async {
    final PaisesOrigenProcedenciaModelo res =
        await _repositorio.getPaisOrigenProcedencia(nombre);

    _controlador.ingresoModelo.idPaisOrigen = res.idLocalizacion.toString();
  }

  Future<void> _getPaisProcedencia(String nombre) async {
    final PaisesOrigenProcedenciaModelo res =
        await _repositorio.getPaisOrigenProcedencia(nombre);

    _controlador.ingresoModelo.idPaisProcedencia =
        res.idLocalizacion.toString();
  }

  Future<void> _getPaisDestino(String nombre) async {
    final LocalizacionModelo? res = await _repositorio.getPaisporNombre(nombre);

    _controlador.ingresoModelo.idPaisDestino = res?.idGuia.toString();
  }

  Future<void> _getPuntoIngreso(String nombre) async {
    final PuertosCatalogoModelo? res =
        await _repositorio.getPuertoPorNombre(nombre);

    _controlador.ingresoModelo.idPuntoIngreso = res?.idPuerto.toString();
  }

  Future<void> _getPuntoSalida(String nombre) async {
    final PuertosCatalogoModelo? res =
        await _repositorio.getPuertoPorNombre(nombre);

    _controlador.ingresoModelo.idPuntoSalida = res?.idPuerto.toString();
  }

  bool validarFormulario() {
    bool esValido = true;

    if (_controlador.ingresoModelo.paisOrigen == null ||
        _controlador.ingresoModelo.paisOrigen == '') {
      esValido = false;
      errorPaisOrigen = CAMPO_REQUERIDO;
    } else {
      errorPaisOrigen = null;
    }

    if (_controlador.ingresoModelo.paisProcedencia == null ||
        _controlador.ingresoModelo.paisProcedencia == '') {
      esValido = false;
      errorPaisProcedencia = CAMPO_REQUERIDO;
    } else {
      errorPaisProcedencia = null;
    }

    if (_controlador.ingresoModelo.paisDestino == null ||
        _controlador.ingresoModelo.paisDestino == '') {
      esValido = false;
      errorPaisDestino = CAMPO_REQUERIDO;
    } else {
      errorPaisDestino = null;
    }

    if (_controlador.ingresoModelo.puntoIngreso == null ||
        _controlador.ingresoModelo.puntoIngreso == '') {
      esValido = false;
      errorPuntoIngreso = CAMPO_REQUERIDO;
    } else {
      errorPuntoIngreso = null;
    }

    if (_controlador.ingresoModelo.puntoSalida == null ||
        _controlador.ingresoModelo.puntoSalida == '') {
      esValido = false;
      errorPuntoSalida = CAMPO_REQUERIDO;
    } else {
      errorPuntoSalida = null;
    }

    if (_controlador.ingresoModelo.placaVehiculo == null ||
        _controlador.ingresoModelo.placaVehiculo == '') {
      esValido = false;
      errorPlacaVehiculo = CAMPO_REQUERIDO;
    } else {
      errorPlacaVehiculo = null;
    }

    if (_controlador.ingresoModelo.dda == null ||
        _controlador.ingresoModelo.dda == '') {
      esValido = false;
      errorDDA = CAMPO_REQUERIDO;
    } else {
      errorDDA = null;
    }

    if (_controlador.ingresoModelo.precintoSticker == null ||
        _controlador.ingresoModelo.precintoSticker == '') {
      esValido = false;
      errorPrecinto = CAMPO_REQUERIDO;
    } else {
      errorPrecinto = null;
    }

    update(['idValidacion']);

    return esValido;
  }
}

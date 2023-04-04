import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_sv_controller.dart';
import 'package:agro_servicios/app/utils/catalogos/catologos_seguimiento_control_sv.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SeguimientoCuarentenarioPaso2SvController extends GetxController {
  final _controlador = Get.find<SeguimientoCuarentenarioSvController>();

  late TextEditingController cantidadController;
  late TextEditingController severidadController;
  late TextEditingController poblacionController;
  late TextEditingController descripcionController;

  String? _cambioMonitoreoPlaga;
  String _cambioPresenciaPlaga = 'No';

  String? errorCantidadTotal;
  String? errorCantidadVigilada;
  String? errorActividad;
  String? errorEtapaCultivo;
  String? errorRegistrosMonitoreo;
  String? errorPresenciaPlaga;
  String? errorCantidadAfectada;
  String? errorIncidencia;
  String? errorSeveridad;
  String? errorFasePlaga;
  String? errorOrganoAfectado;
  String? errorDistribucionPlaga;
  String? errorPoblacion;
  String? errorDescripcionSintomas;

  bool? sinCambioMonitoreo;
  bool sinCambioPresencia = false;
  bool _camposActivos = false;

  RxString incidencia = ''.obs;

  List<String>? _listaFaseDesarrolloPlaga =
      CatalogosSeguimientoControlSv().getFasePlagaListString();

  List<String>? _listaOrganoAfectado =
      CatalogosSeguimientoControlSv().getOrganoAfectadoListString();

  List<String>? _listaDistribucionPlaga =
      CatalogosSeguimientoControlSv().getDistribucionPlagaListString();

  @override
  void onInit() {
    _controlador.seguimientoModelo.ausenciaPlagas = 'No';

    cantidadController = TextEditingController();
    severidadController = TextEditingController();
    poblacionController = TextEditingController();
    descripcionController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    cantidadController.dispose();
    severidadController.dispose();
    poblacionController.dispose();
    descripcionController.dispose();
    super.onClose();
  }

  List<String> get listaFase => _listaFaseDesarrolloPlaga!;

  List<String> get listaOrganoAfectado => _listaOrganoAfectado!;

  List<String> get listaDistribucion => _listaDistribucionPlaga!;

  get cambioMonitoreoPlaga => _cambioMonitoreoPlaga;

  get cambioPresenciaPlaga => _cambioPresenciaPlaga;

  bool get camposActivos => _camposActivos;

  get cantidadAfectada => _controlador.seguimientoModelo.cantidadAfectada;

  get faseDesarrolloPlaga => _controlador.seguimientoModelo.faseDesarrolloPlaga;

  get organoAfectado => _controlador.seguimientoModelo.organoAfectado;

  get destribucionPlaga => _controlador.seguimientoModelo.distribucionPlaga;

  set numeroSeguiminetoPlanificado(valor) =>
      _controlador.seguimientoModelo.numeroSeguimientosPlanificados = valor;

  set cantidadTotal(valor) =>
      _controlador.seguimientoModelo.cantidadTotal = valor;

  set cantidadVigilada(valor) {
    _controlador.seguimientoModelo.cantidadVigilada = valor;
    calcularIncidencia();
  }

  set actividad(valor) => _controlador.seguimientoModelo.actividad = valor;

  set etapaCultivo(valor) =>
      _controlador.seguimientoModelo.etapaCultivo = valor;

  set cantidadAfectada(valor) {
    _controlador.seguimientoModelo.cantidadAfectada = valor;
    calcularIncidencia();
  }

  set severidad(valor) =>
      _controlador.seguimientoModelo.porcentajeSeveridad = valor;

  set faseDesarrolloPlaga(valor) {
    _controlador.seguimientoModelo.faseDesarrolloPlaga = valor;
  }

  set organoAfectado(valor) =>
      _controlador.seguimientoModelo.organoAfectado = valor;

  set distribucionPlaga(valor) =>
      _controlador.seguimientoModelo.distribucionPlaga = valor;

  set poblacion(valor) => _controlador.seguimientoModelo.poblacion = valor;

  set descripcionSintomas(valor) =>
      _controlador.seguimientoModelo.descripcionSintomas = valor;

  set cambioMonitoreoPlaga(valor) {
    _controlador.seguimientoModelo.registroMonitoreoPlagas = valor;
    _cambioMonitoreoPlaga = valor;
    update(['idCambioMonitoreo']);
  }

  set cambioPresenciaPlaga(valor) {
    _controlador.seguimientoModelo.ausenciaPlagas = valor;
    _cambioPresenciaPlaga = valor;
    _camposActivos = valor == 'Si' ? true : false;
    if (!_camposActivos) {
      limpiarInactivables();
    } else {
      llenarCombosInactivable();
    }
    update(['idCambioPresencia', 'idInactivable']);
  }

  void calcularIncidencia() {
    double inc = 0;
    if ((_controlador.seguimientoModelo.cantidadVigilada != null &&
            _controlador.seguimientoModelo.cantidadVigilada != '') &&
        (_controlador.seguimientoModelo.cantidadAfectada != null &&
            _controlador.seguimientoModelo.cantidadAfectada != '')) {
      inc = (double.parse(_controlador.seguimientoModelo.cantidadAfectada!) *
              100) /
          double.parse(_controlador.seguimientoModelo.cantidadVigilada!);
      incidencia.value = inc.toStringAsFixed(2);
      _controlador.seguimientoModelo.porcentajeIncidencia =
          inc.toStringAsFixed(2);
    } else {
      incidencia.value = '';
      _controlador.seguimientoModelo.porcentajeIncidencia = '';
    }
  }

  void llenarCombosInactivable() {
    _listaFaseDesarrolloPlaga =
        CatalogosSeguimientoControlSv().getFasePlagaListString();

    _listaOrganoAfectado =
        CatalogosSeguimientoControlSv().getOrganoAfectadoListString();

    _listaDistribucionPlaga =
        CatalogosSeguimientoControlSv().getDistribucionPlagaListString();
  }

  void limpiarInactivables() {
    errorCantidadAfectada = null;
    errorIncidencia = null;
    errorSeveridad = null;
    errorFasePlaga = null;
    errorOrganoAfectado = null;
    errorDistribucionPlaga = null;
    errorPoblacion = null;
    errorDescripcionSintomas = null;
    _controlador.seguimientoModelo.porcentajeIncidencia = null;
    incidencia.value = '';

    _controlador.seguimientoModelo.cantidadAfectada = null;
    _controlador.seguimientoModelo.porcentajeIncidencia = null;
    _controlador.seguimientoModelo.porcentajeSeveridad = null;
    _controlador.seguimientoModelo.poblacion = null;
    _controlador.seguimientoModelo.descripcionSintomas = null;

    _listaFaseDesarrolloPlaga = [];
    _listaOrganoAfectado = [];
    _listaDistribucionPlaga = [];

    cantidadController.text = '';
    severidadController.text = '';
    poblacionController.text = '';
    descripcionController.text = '';

    update(['idInactivable']);
  }

  bool validarFormulario() {
    bool esValido = true;

    if (!validarDouble(_controlador.seguimientoModelo.cantidadTotal)) {
      esValido = false;
      errorCantidadTotal = CAMPO_NUMERICO_VALIDO;
    } else {
      errorCantidadTotal = null;
    }

    if (!validarDouble(_controlador.seguimientoModelo.cantidadVigilada)) {
      esValido = false;
      errorCantidadVigilada = CAMPO_NUMERICO_VALIDO;
    } else {
      errorCantidadVigilada = null;
    }

    if (_controlador.seguimientoModelo.actividad == null ||
        _controlador.seguimientoModelo.actividad == '') {
      esValido = false;
      errorActividad = CAMPO_REQUERIDO;
    } else {
      errorActividad = null;
    }

    if (_controlador.seguimientoModelo.etapaCultivo == null ||
        _controlador.seguimientoModelo.etapaCultivo == '') {
      esValido = false;
      errorEtapaCultivo = CAMPO_REQUERIDO;
    } else {
      errorEtapaCultivo = null;
    }

    if (_controlador.seguimientoModelo.registroMonitoreoPlagas == null ||
        _controlador.seguimientoModelo.registroMonitoreoPlagas == '') {
      esValido = false;
      sinCambioMonitoreo = true;
    } else {
      sinCambioMonitoreo = false;
    }

    if (_controlador.seguimientoModelo.ausenciaPlagas == null ||
        _controlador.seguimientoModelo.ausenciaPlagas == '') {
      esValido = false;
      sinCambioPresencia = true;
    } else {
      sinCambioPresencia = false;
    }

    if (_camposActivos) {
      if (!validarDouble(_controlador.seguimientoModelo.cantidadAfectada)) {
        esValido = false;
        errorCantidadAfectada = CAMPO_NUMERICO_VALIDO;
      } else {
        errorCantidadAfectada = null;
      }

      if (_controlador.seguimientoModelo.porcentajeIncidencia == null ||
          _controlador.seguimientoModelo.porcentajeIncidencia == '') {
        esValido = false;
        errorIncidencia = CAMPO_REQUERIDO;
      } else {
        errorIncidencia = null;
      }

      if (_controlador.seguimientoModelo.porcentajeSeveridad == null ||
          _controlador.seguimientoModelo.porcentajeSeveridad == '') {
        esValido = false;
        errorSeveridad = CAMPO_REQUERIDO;
      } else {
        errorSeveridad = null;
      }

      if (_controlador.seguimientoModelo.faseDesarrolloPlaga == null ||
          _controlador.seguimientoModelo.faseDesarrolloPlaga == '') {
        esValido = false;
        errorFasePlaga = CAMPO_REQUERIDO;
      } else {
        errorFasePlaga = null;
      }

      if (_controlador.seguimientoModelo.organoAfectado == null ||
          _controlador.seguimientoModelo.organoAfectado == '') {
        esValido = false;
        errorOrganoAfectado = CAMPO_REQUERIDO;
      } else {
        errorOrganoAfectado = null;
      }

      if (_controlador.seguimientoModelo.distribucionPlaga == null ||
          _controlador.seguimientoModelo.distribucionPlaga == '') {
        esValido = false;
        errorDistribucionPlaga = CAMPO_REQUERIDO;
      } else {
        errorDistribucionPlaga = null;
      }

      if (_controlador.seguimientoModelo.poblacion == null ||
          _controlador.seguimientoModelo.poblacion == '') {
        esValido = false;
        errorPoblacion = CAMPO_REQUERIDO;
      } else {
        errorPoblacion = null;
      }

      if (_controlador.seguimientoModelo.descripcionSintomas == null ||
          _controlador.seguimientoModelo.descripcionSintomas == '') {
        esValido = false;
        errorDescripcionSintomas = CAMPO_REQUERIDO;
      } else {
        errorDescripcionSintomas = null;
      }

      update(['idInactivable']);
    }

    update(['idValidacion', 'idCambioMonitoreo', 'idCambioPresencia']);

    return esValido;
  }
}

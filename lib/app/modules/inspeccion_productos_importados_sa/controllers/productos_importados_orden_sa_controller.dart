import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/productos_importados/productos_importados_orden_modelo.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_sa_controller.dart';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/seleccion_productos_importados_sa_controller.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:agro_servicios/app/data/repository/productos_importados_sa_repository.dart';
import 'package:agro_servicios/app/utils/codigo_trampa.dart';

class ProductosImportadosOrdenSaController extends GetxController {
  final _controlador = Get.find<ProductosImportadosSaController>();

  List<ProductoImportadoModelo> productos =
      Get.find<SeleccionRegistroProductosImportadosSaController>()
          .productosSolicitud;

  final _repositorio = Get.find<ProductosImportadosSaRepository>();

  ProductosImportadosOrdenModelo ordenLaboratorio =
      ProductosImportadosOrdenModelo();

  String ausenciaSuelo = '';
  String ausenciaContaminante = '';
  String ausenciaSintomaPlaga = '';
  String ausenciaPlaga = '';
  String dictamen = '';

  String _entomologico01 = '';
  String _entomologico02 = '';
  String _nematologico01 = '';
  String _nematologico02 = '';
  String _nematologico03 = '';
  String _nematologico04 = '';
  String _nematologico05 = '';
  String _nematologico06 = '';
  String _nematologico07 = '';
  String _nematologico08 = '';
  String _nematologico09 = '';
  String _fitopatologico01 = '';
  String _fitopatologico02 = '';
  String _fitopatologico03 = '';
  String _fitopatologico04 = '';
  String _fitopatologico05 = '';
  String _fitopatologico06 = '';
  String _fitopatologico07 = '';
  String _fitopatologico08 = '';

  RxBool esEntomologico01 = false.obs;
  RxBool esEntomologico02 = false.obs;

  RxBool esNematologico01 = false.obs;
  RxBool esNematologico02 = false.obs;
  RxBool esNematologico03 = false.obs;
  RxBool esNematologico04 = false.obs;
  RxBool esNematologico05 = false.obs;
  RxBool esNematologico06 = false.obs;
  RxBool esNematologico07 = false.obs;
  RxBool esNematologico08 = false.obs;
  RxBool esNematologico09 = false.obs;

  RxBool esFitopatologico01 = false.obs;
  RxBool esFitopatologico02 = false.obs;
  RxBool esFitopatologico03 = false.obs;
  RxBool esFitopatologico04 = false.obs;
  RxBool esFitopatologico05 = false.obs;
  RxBool esFitopatologico06 = false.obs;
  RxBool esFitopatologico07 = false.obs;
  RxBool esFitopatologico08 = false.obs;

  String? errorProducto;
  String? errorTipoCliente;
  String? errorTipoMuestra;
  String? errorConservacionMuestra;
  String? errorActividadOrigen;
  String? errorPesoMustra;
  String? errorPreDiagnostico;
  String? errorDescripcion;
  String? errorFaseFenologica;
  RxBool errorAnalisis = false.obs;
  RxBool validandoGuardado = false.obs;
  RxString mensajeGuardado = DEFECTO_A.obs;
  RxString codigoMuestra = ''.obs;
  String estadoGuardado = '';

  @override
  void onInit() {
    generarCodigo();
    super.onInit();
  }

  set producto(valor) => ordenLaboratorio.nombreProducto = valor;

  set tipoCliente(valor) => ordenLaboratorio.tipoCliente = valor;

  set tipoMuestra(valor) => ordenLaboratorio.tipoMuestra = valor;

  set conservacionMuestra(valor) => ordenLaboratorio.conservacion = valor;

  set actividadOrigen(valor) => ordenLaboratorio.actividadOrigen = valor;

  set peso(valor) => ordenLaboratorio.pesoMuestra = valor;

  set prediagnostico(valor) => ordenLaboratorio.prediagnostico = valor;

  set descrpcion(valor) => ordenLaboratorio.descripcionSintomas = valor;

  set faseFenologica(valor) => ordenLaboratorio.faseFenologica = valor;

  set entomologico01(bool valor) {
    esEntomologico01.value = valor;
    if (valor) {
      _entomologico01 = ', Identificación general de insectos';
    } else {
      _entomologico01 = '';
    }
  }

  set entomologico02(bool valor) {
    esEntomologico02.value = valor;
    if (valor) {
      _entomologico02 = ', Identificación de plagas de granos almacenados';
    } else {
      _entomologico02 = '';
    }
  }

  set nematologico01(bool valor) {
    esNematologico01.value = valor;
    if (valor) {
      _nematologico01 = ', Extracción de Nemátodos (PEE/N/01)';
    } else {
      _nematologico01 = '';
    }
  }

  set nematologico02(bool valor) {
    esNematologico02.value = valor;
    if (valor) {
      _nematologico02 = ', Extracción de Nemátodos (PEE/N/02)';
    } else {
      _nematologico02 = '';
    }
  }

  set nematologico03(bool valor) {
    esNematologico03.value = valor;
    if (valor) {
      _nematologico03 = ', Extracción de Nemátodos (PEE/N/03)';
    } else {
      _nematologico03 = '';
    }
  }

  set nematologico04(bool valor) {
    esNematologico04.value = valor;
    if (valor) {
      _nematologico04 = ', Extracción de Nemátodos (PEE/N/06)';
    } else {
      _nematologico04 = '';
    }
  }

  set nematologico05(bool valor) {
    esNematologico05.value = valor;
    if (valor) {
      _nematologico05 = ', Extracción de Nemátodos (PEE/N/09)';
    } else {
      _nematologico05 = '';
    }
  }

  set nematologico06(bool valor) {
    esNematologico06.value = valor;
    if (valor) {
      _nematologico06 = ', Extracción de Nemátodos (PEE/N/12)';
    } else {
      _nematologico06 = '';
    }
  }

  set nematologico07(bool valor) {
    esNematologico07.value = valor;
    if (valor) {
      _nematologico07 = ', Extracción de Nemátodos (PEE/N/14)';
    } else {
      _nematologico07 = '';
    }
  }

  set nematologico08(bool valor) {
    esNematologico08.value = valor;
    if (valor) {
      _nematologico08 = ', Identificación a nivel de especie (PEE/N/07)';
    } else {
      _nematologico08 = '';
    }
  }

  set nematologico09(bool valor) {
    esNematologico09.value = valor;
    if (valor) {
      _nematologico09 = ', Identificación a nivel de especie (PEE/N/08)';
    } else {
      _nematologico09 = '';
    }
  }

  set fitopatologico01(bool valor) {
    esFitopatologico01.value = valor;
    if (valor) {
      _fitopatologico01 =
          ', Identificación de bacterias fitopatógenas hasta especie (PEE/FP/01)';
    } else {
      _fitopatologico01 = '';
    }
  }

  set fitopatologico02(bool valor) {
    esFitopatologico02.value = valor;
    if (valor) {
      _fitopatologico02 =
          ', Aislamiento e identificación mediante pruebas bioquímicas y ELISA DAS de Ralstonia solanacearun (PEE/FP/03)';
    } else {
      _fitopatologico02 = '';
    }
  }

  set fitopatologico03(bool valor) {
    esFitopatologico03.value = valor;
    if (valor) {
      _fitopatologico03 =
          ', Identificación de hongos fitopatógenos hasta especie (PEE/FP/10)';
    } else {
      _fitopatologico03 = '';
    }
  }

  set fitopatologico04(bool valor) {
    esFitopatologico04.value = valor;
    if (valor) {
      _fitopatologico04 =
          ', Diagnóstico de virus de mosaico de las brácteas del banano por ELISA DAS. (PEE/FP/02)';
    } else {
      _fitopatologico04 = '';
    }
  }

  set fitopatologico05(bool valor) {
    esFitopatologico05.value = valor;
    if (valor) {
      _fitopatologico05 =
          ', Diagnóstico de banana streak virus - BSV (PEE/FP/04 (BSV))';
    } else {
      _fitopatologico05 = '';
    }
  }

  set fitopatologico06(bool valor) {
    esFitopatologico06.value = valor;
    if (valor) {
      _fitopatologico06 =
          ', Diagnóstico de cucumber mosaic virus CMV (PEE/FP/06)';
    } else {
      _fitopatologico06 = '';
    }
  }

  set fitopatologico07(bool valor) {
    esFitopatologico07.value = valor;
    if (valor) {
      _fitopatologico07 =
          ', Diagnóstico de virus por el método de ELISA DAS (PEE/FP/11)';
    } else {
      _fitopatologico07 = '';
    }
  }

  set fitopatologico08(bool valor) {
    esFitopatologico08.value = valor;
    if (valor) {
      _fitopatologico08 =
          ', Diagnóstico de virus por el método de ELISA DAS (PEE/FP/12) (CTV, BBTV, CyMV, PVY)';
    } else {
      _fitopatologico08 = '';
    }
  }

  void iniciarValidacion({String? mensaje}) {
    validandoGuardado.value = true;
    mensajeGuardado.value = mensaje ?? DEFECTO_A;
  }

  void finalizarValidacion(String mensaje) {
    validandoGuardado.value = false;
    mensajeGuardado.value = mensaje;
  }

  Future<void> generarCodigo() async {
    final provinciaContrato = await _repositorio.getProvinciaContrato();

    final fecha = DateTime.now().toUtc().millisecondsSinceEpoch.toString();

    String fechaOrden = '';

    if (_controlador.fechaOrdenLaboratorio != '') {
      fechaOrden = _controlador.fechaOrdenLaboratorio;
    } else {
      fechaOrden = fecha.toString();
    }

    codigoMuestra.value = generarCodigoMuestra(
        provincia: provinciaContrato?.provincia ?? '',
        secuencia: _controlador.listaOrdenes.length,
        fechaInicial: fechaOrden,
        codigoFormulario: 'IPI');

    _controlador.fechaOrdenLaboratorio = fechaOrden;
    ordenLaboratorio.codigoMuestra = codigoMuestra.value;
  }

  bool validarFormulario() {
    bool esValido = true;
    String? analisis;

    analisis = _entomologico01 +
        _entomologico02 +
        _nematologico01 +
        _nematologico02 +
        _nematologico03 +
        _nematologico04 +
        _nematologico05 +
        _nematologico06 +
        _nematologico07 +
        _nematologico08 +
        _nematologico09 +
        _fitopatologico01 +
        _fitopatologico02 +
        _fitopatologico03 +
        _fitopatologico04 +
        _fitopatologico05 +
        _fitopatologico06 +
        _fitopatologico07 +
        _fitopatologico08;

    analisis = removerNprimerosCaracteres(
        cadena: analisis, caracterSeparador: ',', cantidad: 2);

    ordenLaboratorio.analisis = analisis;

    if (ordenLaboratorio.nombreProducto == null ||
        ordenLaboratorio.nombreProducto == ''.trim()) {
      esValido = false;
      errorProducto = CAMPO_REQUERIDO;
    } else {
      errorProducto = null;
    }

    if (ordenLaboratorio.tipoCliente == null ||
        ordenLaboratorio.tipoCliente == ''.trim()) {
      esValido = false;
      errorTipoCliente = CAMPO_REQUERIDO;
    } else {
      errorTipoCliente = null;
    }

    if (ordenLaboratorio.tipoMuestra == null ||
        ordenLaboratorio.tipoMuestra == ''.trim()) {
      esValido = false;
      errorTipoMuestra = CAMPO_REQUERIDO;
    } else {
      errorTipoMuestra = null;
    }

    if (ordenLaboratorio.conservacion == null ||
        ordenLaboratorio.conservacion == ''.trim()) {
      esValido = false;
      errorConservacionMuestra = CAMPO_REQUERIDO;
    } else {
      errorConservacionMuestra = null;
    }

    if (ordenLaboratorio.actividadOrigen == null ||
        ordenLaboratorio.actividadOrigen == ''.trim()) {
      esValido = false;
      errorActividadOrigen = CAMPO_REQUERIDO;
    } else {
      errorActividadOrigen = null;
    }

    if (ordenLaboratorio.pesoMuestra == null ||
        ordenLaboratorio.pesoMuestra == ''.trim()) {
      esValido = false;
      errorPesoMustra = CAMPO_REQUERIDO;
    } else {
      errorPesoMustra = null;
    }

    if (ordenLaboratorio.prediagnostico == null ||
        ordenLaboratorio.prediagnostico == ''.trim()) {
      esValido = false;
      errorPreDiagnostico = CAMPO_REQUERIDO;
    } else {
      errorPreDiagnostico = null;
    }

    if (ordenLaboratorio.descripcionSintomas == null ||
        ordenLaboratorio.descripcionSintomas == ''.trim()) {
      esValido = false;
      errorDescripcion = CAMPO_REQUERIDO;
    } else {
      errorDescripcion = null;
    }

    if (ordenLaboratorio.faseFenologica == null ||
        ordenLaboratorio.faseFenologica == ''.trim()) {
      esValido = false;
      errorFaseFenologica = CAMPO_REQUERIDO;
    } else {
      errorFaseFenologica = null;
    }

    if (ordenLaboratorio.analisis == null ||
        ordenLaboratorio.analisis == ''.trim()) {
      esValido = false;
      errorAnalisis.value = true;
    } else {
      errorAnalisis.value = false;
    }

    update(['idValidacion']);
    return esValido;
  }

  Future<void> guardarFormulario(
      {required String titulo,
      required Widget icono,
      required Widget mensaje}) async {
    iniciarValidacion(mensaje: ALMACENANDO);

    mostrarModalBottomSheet(titulo: titulo, icono: icono, mensaje: mensaje);

    await Future.delayed(const Duration(seconds: 1));

    // _controlador.listaLaboratorio.add(laboratorioModelo);
    // _controlador.cantidadOrdenes.value = _controlador.listaLaboratorio.length;

    _controlador.listaOrdenes.add(ordenLaboratorio);

    finalizarValidacion(ALMACENADO_EXITO);

    await Future.delayed(const Duration(seconds: 1));

    Get.back();
    Get.back();
  }
}

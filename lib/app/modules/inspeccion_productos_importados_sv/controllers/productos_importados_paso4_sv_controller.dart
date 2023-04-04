import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/catalogos/localizacion_modelo.dart';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';
import 'package:agro_servicios/app/data/repository/productos_importados_sv_repository.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_sv_controller.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/seleccion_productos_importados_sv_controller.dart';

class ProductosImportadosPaso4SvController extends GetxController {
  List<ProductoImportadoModelo> productos =
      Get.find<SeleccionRegistroProductosImportadosSvController>()
          .productosSolicitud;

  final _repositorio = Get.find<ProductosImportadosSvRepository>();
  final _controlador = Get.find<ProductosImportadosSvController>();
  final _ctrSeleccion =
      Get.find<SeleccionRegistroProductosImportadosSvController>();

  List<LocalizacionModelo> provincias = [];

  bool errorSeguimiento = false;
  bool errorDictamen = false;
  bool errorCantidadIngresada = false;
  bool provinciaActivo = false;

  String? errorProvincia;

  @override
  void onInit() {
    obtenerProvincias();
    inicializarPesoIngresado();
    _controlador.inspeccion.seguimientoCuarentenario = 'No';
    super.onInit();
  }

  get seguimientoCuarentenario =>
      _controlador.inspeccion.seguimientoCuarentenario;

  get dictamenFinal => _controlador.inspeccion.dictamenFinal;

  set provincia(valor) => seleccionarProvincia(valor);

  set observaciones(valor) => _controlador.inspeccion.observaciones = valor;

  set seguimientoCuarentenario(valor) {
    _controlador.inspeccion.seguimientoCuarentenario = valor;
    provinciaActivo = valor == 'Si' ? true : false;
    _controlador.inspeccion.provincia = null;
    errorProvincia = null;
    update(['idSeguimiento']);
    update(['idProvincia']);
  }

  set dictamenFinal(valor) {
    _controlador.inspeccion.dictamenFinal = valor;
    update(['idDictamen']);
  }

  void inicializarPesoIngresado() {
    for (var e in _ctrSeleccion.productosSolicitud) {
      e.cantidadIngresada = e.cantidad;
    }
  }

  void actualizarIngreso(int index, String valor) {
    _ctrSeleccion.productosSolicitud[index].cantidadIngresada = valor;
  }

  Future<void> obtenerProvincias() async {
    provincias = await _repositorio.getProvincias();
    update(['idProvincia']);
  }

  Future seleccionarProvincia(int idProvincia) async {
    final provincia = await _repositorio.getProvinciaPorId(idProvincia);
    _controlador.inspeccion.provincia = provincia!.nombre;
  }

  bool validarFormulario() {
    bool esValido = true;

    if (seguimientoCuarentenario == null || seguimientoCuarentenario == '') {
      esValido = false;
      errorSeguimiento = true;
    } else {
      errorSeguimiento = false;
    }

    if (provinciaActivo == true &&
        (_controlador.inspeccion.provincia == null ||
            _controlador.inspeccion.provincia == '')) {
      esValido = false;
      errorProvincia = CAMPO_REQUERIDO;
    } else {
      errorProvincia = null;
    }

    if (dictamenFinal == null || dictamenFinal == '') {
      esValido = false;
      errorDictamen = true;
    } else {
      errorDictamen = false;
    }

    errorCantidadIngresada = false;

    for (var e in _ctrSeleccion.productosSolicitud) {
      if (e.cantidadIngresada == null || e.cantidadIngresada == '') {
        esValido = false;
        errorCantidadIngresada = true;
      }
    }

    update(
        ['idSeguimiento', 'idProvincia', 'idDictamen', 'idCantidadIngresada']);

    return esValido;
  }
}

import 'package:agro_servicios/app/data/models/productos_importados/productos_importados_orden_modelo.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_sv_controller.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/controllers/controlador_base.dart';

class ProductosImportadosPaso3SvController extends GetxController
    with ControladorBase {
  final _controlador = Get.find<ProductosImportadosSvController>();

  String ordenLaboratorio = 'No';

  RxList<ProductosImportadosOrdenModelo> get listaOrdenes =>
      _controlador.listaOrdenes;

  RxBool envioMuesta = false.obs;

  set setOrdenLaboratorio(valor) {
    ordenLaboratorio = valor;

    envioMuesta.value = valor == 'Si' ? true : false;

    _controlador.inspeccion.envioMuestra = valor;
    _controlador.envioMuestra = envioMuesta.value;
    if (!envioMuesta.value) limpiarListaOrdenes();
    update(['idOrdenLaboratorio']);
  }

  set eliminarLote(index) => _controlador.eliminarOrdenesLaboratorio(index);

  void limpiarListaOrdenes() {
    listaOrdenes.clear();
  }
}

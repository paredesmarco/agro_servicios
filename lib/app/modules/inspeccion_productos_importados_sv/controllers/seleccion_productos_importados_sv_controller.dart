import 'package:get/get.dart';

import 'package:agro_servicios/app/data/repository/productos_importados_sv_repository.dart';
import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/productos_importados/solicitud_productos_importados_modelo.dart';

class SeleccionRegistroProductosImportadosSvController extends GetxController
    with ControladorBase {
  final _repositorio = Get.find<ProductosImportadosSvRepository>();

  SolicitudProductosImportadosModelo solicitudRegistro =
      SolicitudProductosImportadosModelo();

  RxList<SolicitudProductosImportadosModelo> listaSolicitudes =
      <SolicitudProductosImportadosModelo>[].obs;

  List<ProductoImportadoModelo> listaProductos = [];

  List<ProductoImportadoModelo> productosSolicitud = [];

  @override
  void onReady() async {
    super.onReady();
    obtenerRegistros();
  }

  set seleccionarProducto(valor) {
    productosSolicitud = valor;
  }

  Future<void> obtenerRegistros() async {
    final res = await _repositorio.getSolicitudesProductosImportados();

    final resProductos = await _repositorio.getProductosSolicitudes();

    listaProductos = resProductos;

    List<SolicitudProductosImportadosModelo> solicitud = [];

    solicitud = res;

    for (var e in solicitud) {
      e.productos = listaProductos.where((producto) {
        return producto.controlF01Id == e.id;
      }).toList();
    }

    listaSolicitudes.value = solicitud;
  }

  Future<bool> comprobarLlenado(String dda) async {
    final res = await _repositorio.getVerificaionDDALlenado(dda);

    if (res?.dda == dda) {
      return true;
    } else {
      return false;
    }
  }
}

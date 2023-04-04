import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/productos_importados/producto_importado_lote_modelo.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/productos_importados_sv_controller.dart';

class ProductosImportadosPaso2SvController extends GetxController {
  final _controlador = Get.find<ProductosImportadosSvController>();

  RxList<ProductoImportadoLoteModelo> get listaLote => _controlador.listaLotes;

  set eliminarLote(index) => _controlador.eliminarLote(index);
}

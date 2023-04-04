import 'package:get/get.dart';

import 'package:agro_servicios/app/data/models/productos_importados/producto_importado_lote_modelo.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_sa_controller.dart';

class ProductosImportadosPaso2SaController extends GetxController {
  final _controlador = Get.find<ProductosImportadosSaController>();

  RxList<ProductoImportadoLoteModelo> get listaLote => _controlador.listaLotes;

  set eliminarLote(index) => _controlador.eliminarLote(index);
}

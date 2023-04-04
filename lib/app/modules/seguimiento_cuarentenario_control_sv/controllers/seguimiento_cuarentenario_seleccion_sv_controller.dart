import 'package:get/get.dart';

import 'package:agro_servicios/app/core/controllers/controlador_base.dart';
import 'package:agro_servicios/app/data/models/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_solicitud_sv_modelo.dart';
import 'package:agro_servicios/app/data/repository/seguimiento_cuarentenario_sv_repository.dart';

class SeguimientoCuarentenarioSeleccionSvController extends GetxController
    with ControladorBase {
  final _seguimientoRepository =
      Get.find<SeguimientoCuarentenarioSvRepository>();

  RxList<SeguimientoCuarentenarioSolicitudSvModelo> listaRegistros =
      <SeguimientoCuarentenarioSolicitudSvModelo>[].obs;

  @override
  void onReady() {
    obtenerSolicitudes();
    super.onReady();
  }

  obtenerSolicitudes() async {
    RespuestaProvider res = await ejecutarConsulta(() {
      return _seguimientoRepository.getSolicitudesSincronizadas();
    });

    RespuestaProvider resProductos = await ejecutarConsulta(() {
      return _seguimientoRepository.getSolicitudesProductosSincronizados();
    });

    List<SeguimientoCuarentenarioSolicitudSvModelo> solicitud = res.cuerpo;
    List<SeguimientoCuarentenarioProductoSvModelo> productos =
        resProductos.cuerpo;

    for (var e in solicitud) {
      e.solicitudProductos = productos.where((producto) {
        return producto.idSolicitud == e.id;
      }).toList();
    }

    listaRegistros.value = solicitud;
  }
}

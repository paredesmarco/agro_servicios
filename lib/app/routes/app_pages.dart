import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/bindings/seguimiento_cuarentenario_sv_binding.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/seguimiento_cuarentenario_sv_page.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/bindings/transito_ingreso_producto_control_sv_binding.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/pages/ingreso_producto_control_sv.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/bindings/salida_verificacion_control_sv_binding.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/pages/transito_salida_verificacion_control_sv.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/bindings/caracterizacion_fr_mf_sv_bindig.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/bindings/muestreo_mf_sv_binding.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/bindings/muestreo_mf_sv_laboratorio_bindig.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/bindings/trampeo_mf_sv_binding.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/bindings/trampeo_mf_sv_datos_trampa_binding.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/bindings/trampeo_mf_sv_laboratorio_bindig.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/caracterizacion_fr_mf_sv.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/pages/ingreso_laboratorio_muestreo_mf_sv.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/muestreo_mf_sv.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/ingreso_datos_trampa_mf_sv.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/ingreso_muestra_laboratorio_mf_sv.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/pages/nuevo_trampeo_mf_sv.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/trampeo_mf_sv.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/ingreso_datos_trampa_vista.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/ingreso_muestra_laboraotorio_vista.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/nuevo_trampeo_vista.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/pages/ingreso_muestra_laboraotorio_vista.dart';
import 'package:agro_servicios/app/modules/home/home.dart';
import 'package:agro_servicios/app/modules/home/ruta_home.dart';
import 'package:agro_servicios/app/modules/login/login.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/registro_trampeo.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/vigilancia.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/bindings/embalaje_control_sv_binding.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/bindings/embalaje_laboratorio_control_sv_binding.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/embalaje_control_sv.dart';
import 'package:agro_servicios/app/modules/embalaje_control_sv/pages/ingreso_muestra_laboratorio_control_sv.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/bindings/transito_ingreso_control_sv_binding.dart';
import 'package:agro_servicios/app/modules/transito_ingreso_control_sv/ingreso_control_sv.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/bindings/salida_control_sv_binding.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/salida_control_sv.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_laboratorio_sv_page.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/pages/seguimiento_cuarentenario_nuevo_sv_page.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/productos_importados_sa.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/bindings/productos_importados_sv_bindig.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/bindings/productos_importados_sa_bindig.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_nuevo_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_ingreso_lote_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/pages/producto_importado_ingreso_orden_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/productos_importados_sv.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/pages/producto_importado_nuevo_sa.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/pages/producto_importado_ingreso_lote_sa.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/pages/producto_importado_ingreso_orden_sa.dart';
import 'package:agro_servicios/app/modules/trips/trips_sv.dart';
import 'package:agro_servicios/app/modules/trips/bindings/trips_binding.dart';
import 'package:agro_servicios/app/modules/trips/pages/trips_ver_sv.dart';
import 'package:agro_servicios/app/modules/minador_sv/bindings/minador_binding.dart';
import 'package:agro_servicios/app/modules/minador_sv/minador_sv.dart';
import 'package:agro_servicios/app/modules/minador_sv/pages/minador_sincronizar_sv.dart';
import 'package:agro_servicios/app/modules/minador_sv/pages/minador_ver_sv.dart';
import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso1.dart';
import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso3.dart';
import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso4.dart';
import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso5.dart';
import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso6.dart';
import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso2.dart';
part './app_rutas.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Rutas.INITIAL,
      page: () => const RutaHome(),
    ),
    GetPage(
      name: Rutas.HOME,
      page: () => const Home(),
    ),
    GetPage(
      name: Rutas.LOGIN,
      page: () => const Login(),
    ),
    GetPage(
      name: Rutas.TRAMPEOVF,
      page: () => const RegistroTrampeo(),
    ),
    GetPage(
      name: Rutas.TRAMPEOVFNUEVO,
      page: () => const FormularioNuevoTrampeoVista(),
    ),
    GetPage(
      name: Rutas.TRAMPEOVFINGRESO,
      page: () => const FormularioDatosIngresoTrampa(),
    ),
    GetPage(
      name: Rutas.TRAMPEOVFLABORATORIO,
      page: () => const FormularioDatosMuestraLaboratorio(),
    ),
    GetPage(
      name: Rutas.VIGILANCIAVF,
      page: () => const Vigilancia(),
    ),
    GetPage(
      name: Rutas.VIGILANCIAVFLABORATORIO,
      page: () => const FormularioDatosMuestraLaboratorioVigilancia(),
    ),
    GetPage(
        name: Rutas.TRAMPEOMFSV,
        page: () => const TrampeoMfSv(),
        binding: TrampeoMfSvBinding()),
    GetPage(
      name: Rutas.TRAMPEOMFSVNUEVO,
      page: () => NuevoTrampeoMfSv(),
    ),
    GetPage(
      name: Rutas.TRAMPEOMFSVDATOSTRAMPA,
      page: () => const IngresoDatosTrampaMfSv(),
      binding: TrampeoMfSvDatosTrampaBinding(),
    ),
    GetPage(
      name: Rutas.TRAMPEOMFSVLABORATORIO,
      page: () => IngresoMuesteaLaboratorioMfSv(),
      binding: TrampeoMfSvLaboratorioBinding(),
    ),
    GetPage(
      name: Rutas.MUESTREOMFSVNUEVO,
      page: () => MuestreoMfSv(),
      binding: MuestreoMfSvBinding(),
    ),
    GetPage(
      name: Rutas.MUESTREOMFSVLABORATORIO,
      page: () => MuestreoMfSvLaboratorio(),
      binding: MuestreoMfSvLaboratorioBinding(),
    ),
    GetPage(
      name: Rutas.FRUTICULAMFSV,
      page: () => CaracterizacionFrMfSv(),
      binding: CaracterizacionFrMfSvBinding(),
    ),
    GetPage(
      name: Rutas.EMBALAJECONTROLSV,
      page: () => const EmbaleControlSv(),
      binding: EmbalajeControlBinding(),
    ),
    GetPage(
      name: Rutas.EMBALAJELABORATORIOCONTROLSV,
      page: () => const EmbalajeMuestraLaboratorioControlSv(),
      binding: EmbalajeOrdenControlSvBinding(),
    ),
    GetPage(
      name: Rutas.INGRESOCONTROLSV,
      page: () => IngresoControlSv(),
      binding: IngresoControlSvBinding(),
    ),
    GetPage(
      name: Rutas.INGRESOPRODUCTOCONTROLSV,
      page: () => const IngresoProductoControlSv(),
      binding: IngresoProductoControlSvBinding(),
    ),
    GetPage(
      name: Rutas.SALIDACONTROLSV,
      page: () => const TransitoSalidaControlSv(),
      binding: SalidaControlSvBinding(),
    ),
    GetPage(
      name: Rutas.SALIDAVERIFICACIONCONTROLSV,
      page: () => const TransitoSalidaVerificacionControlSv(),
      binding: SalidaVerificacionContrlSvBinding(),
    ),
    GetPage(
      name: Rutas.SEGUIMIENTOCUARENTENARIOCONTROLSV,
      page: () => SeguimientoCuarentenarioSvPage(),
      binding: SeguimientoCuarentenarioSvBinding(),
    ),
    GetPage(
      name: Rutas.SEGUIMIENTOCUARENTENARIONUEVOCONTROLSV,
      page: () => const SeguimientoCuarentenarioNuevoSvPage(),
      binding: SeguimientoCuarentenarioSvBinding(),
    ),
    GetPage(
      name: Rutas.SEGUIMIENTOCUARENTENARIOLABORATORIOSV,
      page: () => const SeguimientoCuarentenarioLaboratorioSvPage(),
      binding: SeguimientoCuarentenarioSvBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSSV,
      page: () => const ProductosImportadosSv(),
      binding: ProductosImportadosSvBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSNUEVOSV,
      page: () => const NuevoProductoImportadoSv(),
      binding: ProductosImportadosSvBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSLOTESV,
      page: () => const ProductoImportadoIngresoLoteSv(),
      binding: ProductosImportadosSvBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSORDENSV,
      page: () => const ProductoImportadoIngresOrdenSv(),
      binding: ProductosImportadosSvBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSSA,
      page: () => const ProductosImportadosSa(),
      binding: ProductosImportadosSaBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSNUEVOSA,
      page: () => const NuevoProductoImportadoSa(),
      binding: ProductosImportadosSaBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSLOTESA,
      page: () => const ProductoImportadoIngresoLoteSa(),
      binding: ProductosImportadosSaBinding(),
    ),
    GetPage(
      name: Rutas.PRODUCTOSIMPORTADOSORDENSA,
      page: () => const ProductoImportadoIngresOrdenSa(),
      binding: ProductosImportadosSaBinding(),
    ),
    GetPage(
      name: Rutas.TRIPSSV,
      page: () => const TripsSv(),
      binding: TripsBinding(),
    ),
    // GetPage(
    //   name: Rutas.TRIPSSINCRONIZARSV,
    //   page: () => TripsSincronizarSv(),
    // ),
    GetPage(
      name: Rutas.TRIPSVERSV,
      page: () => TripsVerSv(),
      binding: TripsBinding(),
    ),

    GetPage(
      name: Rutas.MINADORSV,
      page: () => const MinadorSv(),
      binding: MinadorBinding(),
    ),

    GetPage(
      name: Rutas.MINADORSINCRONIZARSV,
      page: () => MinadorSincronizarSv(),
    ),
    GetPage(
      name: Rutas.MINADORVERSV,
      page: () => MinadorVerSv(),
      binding: MinadorBinding(),
    ),
    GetPage(name: Rutas.DATOSREGISTRO, page: () => DatosRegistroPaso1()),
    GetPage(name: Rutas.DATOSENTIDAD, page: () => DatosRegistroPaso2()),
    GetPage(name: Rutas.DATOSFRONTERAENTIDAD, page: () => DatosRegistroPaso3()),
    GetPage(name: Rutas.DATOSMUESTRA, page: () => DatosRegistroPaso4()),
    GetPage(name: Rutas.DATOSCONTAMINANTE, page: () => DatosRegistroPaso5()),
    GetPage(name: Rutas.ACCIONESTOMADAS, page: () => DatosRegistroPaso6()),
  ];
}

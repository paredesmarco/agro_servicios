part of './app_pages.dart';

abstract class Rutas {
  static const INITIAL = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const DETALLE = '/detalle';
  static const TRAMPEOVF = '/trampeo';
  static const TRAMPEOVFNUEVO = '/trampeo_nuevo';
  static const TRAMPEOVFINGRESO = '/trampeo_ingreso';
  static const TRAMPEOVFLABORATORIO = '/trampeo_laboratorio';
  static const VIGILANCIAVF = '/vigilancia';
  static const VIGILANCIAVFLABORATORIO = '/vigilancia_laboratorio';
  static const TRAMPEOMFSV = '/trampeo_mf_sv';
  static const TRAMPEOMFSVONLINE = '/trampeo_mf_sv_sincronizacion';
  static const TRAMPEOMFSOFFLINE = '/trampeo_mf_sv_registro';
  static const TRAMPEOMFSVNUEVO = '/trampeo_mf_sv_nuevo';
  static const TRAMPEOMFSVDATOSTRAMPA = '/trampeo_mf_sv_datos_trampa';
  static const TRAMPEOMFSVLABORATORIO = '/trampeo_mf_sv_laboratorio';
  static const MUESTREOMFSVNUEVO = '/muestreo_mf_sv';
  static const MUESTREOMFSVLABORATORIO = '/muestreo_laboratorio_mf_sv';
  static const FRUTICULAMFSV = '/fruticula_mf_sv';
  static const EMBALAJECONTROLSV = '/embalaje_control_sv';
  static const EMBALAJELABORATORIOCONTROLSV =
      '/embalaje_laboratorio_control_sv';
  static const INGRESOCONTROLSV = '/transito_ingreso_sv';
  static const INGRESOPRODUCTOCONTROLSV = '/ingreso_producto_control_sv';
  static const SALIDACONTROLSV = '/transito_salida_sv';
  static const SALIDAVERIFICACIONCONTROLSV = '/salida_verificacion_control_sv';
  static const SEGUIMIENTOCUARENTENARIOCONTROLSV =
      '/seguimiento_cuarentenario_sv';
  static const SEGUIMIENTOCUARENTENARIONUEVOCONTROLSV =
      '/seguimiento_cuarentenario_nuevo_sv';
  static const SEGUIMIENTOCUARENTENARIOLABORATORIOSV =
      '/seguimiento_cuarentenario_laboratorio_sv';

  //Formulario de Inspección de productos Importados SV
  static const PRODUCTOSIMPORTADOSSV = '/productos_importados_sv';
  static const PRODUCTOSIMPORTADOSNUEVOSV = '/productos_importados_nuevo_sv';
  static const PRODUCTOSIMPORTADOSLOTESV = '/productos_importados_lote_sv';
  static const PRODUCTOSIMPORTADOSORDENSV = '/productos_importados_orden_sv';

  //Formulario de Inspección de productos Importados SA
  static const PRODUCTOSIMPORTADOSSA = '/productos_importados_sa';
  static const PRODUCTOSIMPORTADOSNUEVOSA = '/productos_importados_nuevo_sa';
  static const PRODUCTOSIMPORTADOSLOTESA = '/productos_importados_lote_sa';
  static const PRODUCTOSIMPORTADOSORDENSA = '/productos_importados_orden_sa';

  //Trips
  static const TRIPSSV = '/trips_sv';
  static const TRIPSFORMSV = '/trips_form_sv';
  static const TRIPSSINCRONIZARSV = '/trips_sincronizar_sv';
  static const TRIPSVERSV = '/trips_ver_sv';

  //Minador
  static const MINADORSV = '/minador_sv';
  static const MINADORFORMSV = '/minador_form_sv';
  static const MINADORSINCRONIZARSV = '/minador_sincronizar_sv';
  static const MINADORVERSV = '/minador_ver_sv';

  static const DATOSREGISTRO = '/datosRegistro';
  static const DATOSENTIDAD = '/datosEntidad';
  static const DATOSFRONTERAENTIDAD = '/datosFronteraEntidad';
  static const DATOSMUESTRA = '/datosMuestra';
  static const DATOSCONTAMINANTE = '/datosContaminante';
  static const ACCIONESTOMADAS = '/accionesTomadas';
}

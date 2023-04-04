import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/data/models/transito_salida_control_sv/registros_transito_ingreso_modelo.dart';
import 'package:agro_servicios/app/modules/transito_salida_control_sv/controllers/seleccion_registro_salida_control_sv_controller.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TarjetaRegistros extends StatelessWidget {
  final RegistrosTransitoIngresoModelo registro;
  const TarjetaRegistros({Key? key, required this.registro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool esLlenado =
            await Get.find<SeleccionRegistroSalidaControlSvController>()
                .comprobarLlenado(registro.idIngreso!);
        if (!esLlenado) {
          Get.toNamed(Rutas.SALIDAVERIFICACIONCONTROLSV, arguments: registro);
        } else {
          snackBarExterno(mensaje: 'Formulario ya utilizado', context: context);
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10.0, top: 6.0, bottom: 6.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFefefef),
                    offset: Offset(0.0, 0.0),
                    blurRadius: 20.0),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            registro.nombreRazonSocial ?? 'Razón Social',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colores.TituloFormulario,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.84,
                    child: Column(
                      children: <Widget>[
                        _Textos(
                          etiqueta: 'RUC',
                          contenido: registro.rucCi,
                        ),
                        const SizedBox(height: 10),
                        _Textos(
                            etiqueta: 'País de origen',
                            contenido: registro.paisOrigen),
                        const SizedBox(height: 10),
                        _Textos(
                            etiqueta: 'País de procedencia',
                            contenido: registro.paisProcedencia),
                        const SizedBox(height: 10),
                        _Textos(
                            etiqueta: 'País de destino',
                            contenido: registro.paisDestino),
                        const SizedBox(height: 10),
                        _Textos(
                            etiqueta: 'Punto de ingreso',
                            contenido: registro.puntoIngreso),
                        const SizedBox(height: 10),
                        _Textos(
                            etiqueta: 'Punto de salida',
                            contenido: registro.puntoSalida),
                        const SizedBox(height: 10),
                        _Textos(
                            etiqueta: 'Placa de vehículo',
                            contenido: registro.placaVehiculo),
                        const SizedBox(height: 10),
                        _Textos(etiqueta: '# DDA', contenido: registro.dda),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Textos extends StatelessWidget {
  final String? contenido;
  final String etiqueta;
  const _Textos({Key? key, this.contenido, required this.etiqueta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          child: Text(etiqueta, style: const TextStyle(color: Colores.divider)),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.44,
          child: Text(
            contenido == null ? '' : contenido!,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        )
      ],
    );
  }
}

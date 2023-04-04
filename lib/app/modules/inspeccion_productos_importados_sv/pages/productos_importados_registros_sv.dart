import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/tarjeta_registros.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sv/controllers/seleccion_productos_importados_sv_controller.dart';

class ProductosImportadosSeleccionRegistrolSv
    extends GetView<SeleccionRegistroProductosImportadosSvController> {
  const ProductosImportadosSeleccionRegistrolSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listaSolicitudes.isEmpty) {
        return const CuerpoFormularioSinRegistros(
          titulo: 'Inspección de Productos Importados SA',
        );
      } else {
        return const _Registros();
      }
    });
  }
}

class _Registros
    extends GetView<SeleccionRegistroProductosImportadosSvController> {
  const _Registros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CuerpoFormularioIngreso(
      titulo: 'Inspección de Productos Importados SA',
      widgets: [
        Obx(() {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            itemCount: controller.listaSolicitudes.length,
            itemBuilder: (context, index) {
              String producto = '';
              controller.listaSolicitudes[index].productos?.forEach((e) {
                if (e.nombre != null) {
                  producto =
                      '$producto${e.nombre} (${e.cantidad} Kg, ${e.subtipo}),';
                }
              });
              return TarjetaRegistros(
                onTap: () async {
                  bool esLlenado = await controller.comprobarLlenado(
                      controller.listaSolicitudes[index].dda!);

                  if (esLlenado) {
                    snackBarExterno(
                        mensaje: 'Formulario ya utilizado', context: context);
                  } else {
                    controller.seleccionarProducto =
                        controller.listaSolicitudes[index].productos;

                    controller.solicitudRegistro =
                        controller.listaSolicitudes[index];

                    Get.toNamed(Rutas.PRODUCTOSIMPORTADOSNUEVOSV);
                  }
                },
                titulo: controller.listaSolicitudes[index].razonSocial,
                children: [
                  TextosTarjetas(
                    etiqueta: 'No. PFI',
                    contenido: controller.listaSolicitudes[index].pfi,
                  ),
                  const SizedBox(height: 10),
                  TextosTarjetas(
                    etiqueta: 'No. DDA',
                    contenido: controller.listaSolicitudes[index].dda,
                  ),
                  const SizedBox(height: 10),
                  TextosTarjetas(
                    etiqueta: 'Razón Social',
                    contenido: controller.listaSolicitudes[index].razonSocial,
                  ),
                  const SizedBox(height: 10),
                  TextosTarjetas(
                    etiqueta: 'Producto',
                    contenido: producto,
                  ),
                  const SizedBox(height: 10),
                  TextosTarjetas(
                    etiqueta: 'País de origen',
                    contenido: controller.listaSolicitudes[index].paisOrigen,
                  ),
                ],
              );
            },
          );
        })
      ],
    );
  }
}

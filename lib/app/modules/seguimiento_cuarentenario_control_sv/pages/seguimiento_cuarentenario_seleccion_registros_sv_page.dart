import 'package:agro_servicios/app/core/widgets/contenedor_sin_registros.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/tarjeta_registros.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/modules/seguimiento_cuarentenario_control_sv/controllers/seguimiento_cuarentenario_seleccion_sv_controller.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SeguimientoCuarentenarioSeleccionRegistrosSvPage extends StatelessWidget {
  const SeguimientoCuarentenarioSeleccionRegistrosSvPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CuerpoFormularioIngreso(
      titulo: 'Seguimiento cuarentenario vegetal',
      widgets: [_Registros()],
    );
  }
}

class _Registros
    extends GetView<SeguimientoCuarentenarioSeleccionSvController> {
  const _Registros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listaRegistros.isEmpty) {
        return const ContenedorSinRegistros();
      } else {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          itemCount: controller.listaRegistros.length,
          itemBuilder: (context, index) {
            String producto = '';
            controller.listaRegistros[index].solicitudProductos?.forEach((e) {
              if (e.producto != null) {
                producto =
                    '$producto${e.producto} (${e.peso} Kg, ${e.subtipo}),';
              }
            });
            return TarjetaRegistros(
              onTap: () {
                Get.toNamed(Rutas.SEGUIMIENTOCUARENTENARIONUEVOCONTROLSV,
                    arguments: controller.listaRegistros[index]);
              },
              titulo: controller.listaRegistros[index].razonSocial,
              children: [
                TextosTarjetas(
                  etiqueta: 'Productos:',
                  contenido:
                      removerUltimoCaracter(cadena: producto, caracter: ','),
                ),
                const Espaciador(alto: 10),
                TextosTarjetas(
                    etiqueta: 'País de Origen:',
                    contenido: controller.listaRegistros[index].paisOrigen),
                const Espaciador(alto: 10),
                TextosTarjetas(
                    etiqueta: 'Número de plantas ingresadas:',
                    contenido: controller
                        .listaRegistros[index].numeroPlantasIngreso
                        .toString()),
                const Espaciador(alto: 10),
                TextosTarjetas(
                    etiqueta: 'Documento de Destinación Aduanera:',
                    contenido: controller.listaRegistros[index].idVue)
              ],
            );
          },
        );
      }
    });
  }
}

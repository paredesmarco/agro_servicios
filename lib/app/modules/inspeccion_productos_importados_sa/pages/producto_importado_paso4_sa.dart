import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/inspeccion_productos_importados_sa/controllers/productos_importados_paso4_sa_controller.dart';
import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/styles/estilos_textos.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/core/widgets/mensaje_error_radio_button.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';

class ProductoImportadoPaso4Sa extends StatefulWidget {
  const ProductoImportadoPaso4Sa({Key? key}) : super(key: key);

  @override
  State<ProductoImportadoPaso4Sa> createState() =>
      _ProductoImportadoPaso4SaState();
}

class _ProductoImportadoPaso4SaState extends State<ProductoImportadoPaso4Sa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CuerpoFormularioTabPage(
      children: [
        NombreSeccion(etiqueta: 'Lista de productos'),
        _Tabla(),
        _ErrorCantidadIngresada(),
        _SeguimientoCuarentenario(),
        _Provincia(),
        Espaciador(alto: 20),
        Divider(color: Colores.divider),
        Espaciador(alto: 5),
        _DictamenFinal(),
        _Observaciones(),
      ],
    );
  }
}

class _ErrorCantidadIngresada extends StatelessWidget {
  const _ErrorCantidadIngresada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso4SaController>(
      id: 'idCantidadIngresada',
      builder: (_) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_.errorCantidadIngresada)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const Text(
                      'Los campos de cantidad ingresada son requeridos',
                      style: EstilosTextos.errorTexto,
                    ),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}

class _Tabla extends GetView<ProductosImportadosPaso4SaController> {
  const _Tabla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: GetBuilder<ProductosImportadosPaso4SaController>(
        builder: (_) {
          return DataTable(
            sortAscending: false,
            columns: const [
              DataColumn(
                  label: Text("Producto",
                      style: TextStyle(color: Colores.TituloFormulario))),
              DataColumn(
                  label: Text("Declarado",
                      style: TextStyle(color: Colores.TituloFormulario))),
              DataColumn(
                  label: Text("Ingresado",
                      style: TextStyle(color: Colores.TituloFormulario))),
            ],
            rows: List.generate(controller.productos.length, (index) {
              return DataRow(cells: [
                DataCell(Text(controller.productos[index].nombre ?? '',
                    style: const TextStyle(color: Colores.divider))),
                DataCell(Text(controller.productos[index].cantidad ?? '',
                    style: const TextStyle(color: Colores.divider))),
                DataCell(TextFormField(
                  maxLength: 10,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    ComaTextInputFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
                  ],
                  initialValue: controller.productos[index].cantidad,
                  style: const TextStyle(color: Colores.radio_chechbox),
                  decoration: _buildDecoracionInput(),
                  onChanged: (valor) => _.actualizarIngreso(index, valor),
                )),
              ]);
            }),
          );
        },
      ),
    );
  }

  _buildDecoracionInput() {
    return InputDecoration(
      counter: const Offstage(),
      // errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      labelStyle: const TextStyle(color: Color(0xFFDFDFDF)),
      isDense: true,
      contentPadding:
          const EdgeInsets.only(top: 5, bottom: 2, left: 9, right: 9),
    );
  }
}

class _SeguimientoCuarentenario extends StatelessWidget {
  const _SeguimientoCuarentenario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Requiere seguimiento cuarentenario',
        ),
        GetBuilder<ProductosImportadosPaso4SaController>(
          id: 'idSeguimiento',
          builder: (_) {
            return Row(
              children: [
                Radio(
                  value: 'Si',
                  groupValue: _.seguimientoCuarentenario,
                  onChanged: (valor) => _.seguimientoCuarentenario = valor!,
                ),
                const Text('Si', style: EstilosTextos.radioYcheckbox),
                Radio(
                  value: 'No',
                  groupValue: _.seguimientoCuarentenario,
                  onChanged: (valor) => _.seguimientoCuarentenario = valor!,
                ),
                const Text('No', style: EstilosTextos.radioYcheckbox),
                if (_.errorSeguimiento == true) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Provincia extends StatelessWidget {
  const _Provincia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductosImportadosPaso4SaController>(
      id: 'idProvincia',
      builder: (_) {
        if (_.seguimientoCuarentenario == 'Si') {
          return Combo(
            items: _.provincias
                .map((e) => DropdownMenuItem(
                      value: e.idGuia,
                      child: Text(e.nombre!),
                    ))
                .toList(),
            label: 'Provincia',
            onChanged: (valor) => _.provincia = valor,
            errorText: _.errorProvincia,
            enabled: _.provinciaActivo,
          );
        } else {
          return const ComboBloqueado(label: 'Provincia', height: 44);
        }
      },
    );
  }
}

class _DictamenFinal extends StatelessWidget {
  const _DictamenFinal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CampoDescripcion(
          etiqueta: 'Dictamen Final',
        ),
        GetBuilder<ProductosImportadosPaso4SaController>(
          id: 'idDictamen',
          builder: (_) {
            return Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Aprobar',
                      groupValue: _.dictamenFinal,
                      onChanged: (valor) => _.dictamenFinal = valor!,
                    ),
                    const Text('Aprobar', style: EstilosTextos.radioYcheckbox),
                    Radio(
                      value: 'Subsanar',
                      groupValue: _.dictamenFinal,
                      onChanged: (valor) => _.dictamenFinal = valor!,
                    ),
                    const Text('Subsanar', style: EstilosTextos.radioYcheckbox),
                    Radio(
                      value: 'Desaprobar',
                      groupValue: _.dictamenFinal,
                      onChanged: (valor) => _.dictamenFinal = valor!,
                    ),
                    const Text('Desaprobar',
                        style: EstilosTextos.radioYcheckbox),
                  ],
                ),
                if (_.errorDictamen == true) const MensajeErrorRadioButton()
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Observaciones extends GetView<ProductosImportadosPaso4SaController> {
  const _Observaciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CampoTexto(
      maxLength: 256,
      label: 'Observaciones',
      onChanged: (valor) => controller.observaciones = valor,
    );
  }
}

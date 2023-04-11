import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/srollable_widget.dart';
import 'package:agro_servicios/app/core/widgets/text_dialog_widget.dart';
import 'package:agro_servicios/app/data/models/registroInformacion/contaminanteModelo.dart';
import 'package:agro_servicios/app/modules/registroInformacion/controllers/registroInformacionController.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:agro_servicios/app/utils/utilsTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DatosRegistroPaso5 extends StatefulWidget {
  final controlador = Get.find<RegistroInformacionController>();
  DatosRegistroPaso5({Key? key}) : super(key: key);

  @override
  State<DatosRegistroPaso5> createState() => _DatosRegistroState();
}

class _DatosRegistroState extends State<DatosRegistroPaso5> {
  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return GetBuilder<RegistroInformacionController>(
        builder: (_) => CuerpoFormularioIngreso(
            titulo: "Formulario Ingreso",
            widgets: [
              NombreSeccion(
                etiqueta: 'Contaminante',
              ),
              ScrollableWidget(child: _buildDataTableContaminantes()),
              //_buildContaminantes(),
              buildBotonRegresar(),
            ],
            botonFormulario: _buildBotonContinuar()));
  }

  Widget buildBotonRegresar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      height: 28,
      width: 28,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: CircleBorder(),
          backgroundColor: Colors.white,
        ),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        onPressed: () =>
            Navigator.pushReplacementNamed(context, 'datosMuestra'),
      ),
    );
  }

  Widget _buildDataTableContaminantes() {
    final controlador = Get.find<RegistroInformacionController>();
    final columns = [
      'Contaminante',
      'Unidad',
      'Resultado',
      'Codex',
      'UE',
      'EEUU',
      '+/-'
    ];
    return DataTable(
      columns: getColumns(columns),
      rows: getRows(controlador.contaminantes),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(label: Text(column));
    }).toList();
  }

  List<DataRow> getRows(List<ContaminanteModelo> contaminantes) =>
      contaminantes.map((ContaminanteModelo contaminante) {
        final cells = [
          contaminante.nombre,
          contaminante.unidad,
          contaminante.resultado,
          contaminante.codex,
          contaminante.ue,
          contaminante.eeuu,
          contaminante.positivo
        ];

        final limitesCodex = contaminante.codex.toString().split("–");
        final limitesUE = contaminante.ue.toString().split("–");
        final limitesEEUU = contaminante.eeuu.toString().split("–");
        var excedioLimiteCodex = !(double.parse(limitesCodex[0].toString()) <=
                double.parse(contaminante.resultado.toString()) &&
            double.parse(contaminante.resultado.toString()) <=
                double.parse(limitesCodex[1].toString()));
        var excedioLimiteUE = !(double.parse(limitesUE[0].toString()) <=
                double.parse(contaminante.resultado.toString()) &&
            double.parse(contaminante.resultado.toString()) <=
                double.parse(limitesUE[1].toString()));
        var excedioLimiteEEUU = !(double.parse(limitesEEUU[0].toString()) <=
                double.parse(contaminante.resultado.toString()) &&
            double.parse(contaminante.resultado.toString()) <=
                double.parse(limitesEEUU[1].toString()));
        return DataRow(
          cells: UtilsTable.modelBuilder(cells, (index, cell) {
            final showEditing = index == 2;
            var excedioLimite = false;
            if (index == 3) {
              excedioLimite = excedioLimiteCodex;
            }
            if (index == 4) {
              excedioLimite = excedioLimiteUE;
            }
            if (index == 5) {
              excedioLimite = excedioLimiteEEUU;
            }
            return DataCell(
                Container(
                    color: excedioLimite == true ? Colores.red : null,
                    child: Text('$cell')),
                showEditIcon: showEditing, onTap: () {
              switch (index) {
                case 2:
                  editResultadoContaminante(contaminante);
                  break;
              }
            });
          }),
        );
      }).toList();

  Future editResultadoContaminante(ContaminanteModelo editContaminante) async {
    final controlador = Get.find<RegistroInformacionController>();
    final resultado = await showTextDialog(context,
        title: "Resultado", value: editContaminante.resultado.toString());

    setState(() => controlador.contaminantes =
            controlador.contaminantes.map((contaminante) {
          final isEditedContaminante = contaminante == editContaminante;
          return isEditedContaminante
              ? contaminante.copy(resultado: resultado)
              : contaminante;
        }).toList());
  }

  BotonPlano _buildBotonContinuar() {
    final controlador = Get.find<RegistroInformacionController>();
    return BotonPlano(
      texto: 'Continuar',
      color: Color(0XFF1ABC9C),
      funcion: () async {
        bool valido = controlador.validarFormulario();
        if (valido) {
          Navigator.pushReplacementNamed(context, 'accionesTomadas');
        } else
          snackBarExterno(
            mensaje: SNACK_OBLIGATORIOS,
            context: Get.context!,
            elevation: 6,
            snackBarBehavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
          );
      },
      icono: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
    );
  }
}

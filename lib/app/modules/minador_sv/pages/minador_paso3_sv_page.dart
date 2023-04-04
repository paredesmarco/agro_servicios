import 'package:agro_servicios/app/modules/minador_sv/controllers/minador_paso3_controller.dart';
import 'package:agro_servicios/app/modules/minador_sv/widgets/column_builder.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MinadorPaso3SvPage extends StatelessWidget {
  const MinadorPaso3SvPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
      widgets: [
        BuildObservacion(),
        const BuildRepresentante(),
        const Espaciador(alto: 20),
        const BuildTextoExplicativo(),
      ],
    );
  }
}

class BuildTextoExplicativo extends StatelessWidget {
  const BuildTextoExplicativo({super.key});
  @override
  Widget build(BuildContext context) {
    return const NombreSeccion(
        etiqueta:
            'Por lo que de acuerdo con los procedimientos de inspección de AGROCALIDAD a los cuales se ha sometido el interesado, se procede a:');
  }
}

class BuildObservacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinadorPaso3Controller>(
        id: 'observaciones',
        builder: (_) {
          return CampoTexto(
              maxLength: 512,
              initialValue: _.getObservaciones,
              onChanged: (value) {
                _.guardarObservacion(value);
              },
              textInputFormatter: [
                FilteringTextInputFormatter.allow(
                    RegExp("[a-z A-Z á-ú Á-Ú 0-9.()]"))
              ],
              label: "Observaciones");
        });
  }
}

class BuildRepresentante extends StatelessWidget {
  const BuildRepresentante({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinadorPaso3Controller>(
        id: 'representante',
        builder: (_) {
          return CampoTexto(
              maxLength: 256,
              initialValue: _.getRepresentante,
              errorText: _.errorRepresentante,
              textInputFormatter: [
                FilteringTextInputFormatter.allow(
                    RegExp("[a-z A-Z á-ú Á-Ú 0-9]"))
              ],
              onChanged: (value) {
                _.guardarRepresentante(value);
              },
              label: "Representante de la Empresa");
        });
  }
}

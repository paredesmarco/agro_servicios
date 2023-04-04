import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_productor_controller.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvPaso1 extends StatefulWidget {
  const CaracterizacionFrMfSvPaso1({Key? key}) : super(key: key);

  @override
  State<CaracterizacionFrMfSvPaso1> createState() =>
      _CaracterizacionFrMfSvPaso1State();
}

class _CaracterizacionFrMfSvPaso1State extends State<CaracterizacionFrMfSvPaso1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return CuerpoFormularioTabPage(
      children: <Widget>[
        const NombreSeccion(etiqueta: 'Datos del productor'),
        _buildNombre(),
        _buildCedulaRuc(),
        _builTelefono(),
      ],
    );
  }

  Widget _buildNombre() {
    return GetBuilder<CaracterizacionFrMfSvProductorController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 250,
          onChanged: (valor) {
            _.setNombre = valor;
          },
          label: 'Nombre de asociación o productor',
          errorText: _.errorNombre,
        );
      },
    );
  }

  Widget _buildCedulaRuc() {
    return GetBuilder<CaracterizacionFrMfSvProductorController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 13,
          onChanged: (valor) {
            _.setIdentificador = valor;
          },
          label: 'Número de cédula o RUC',
          errorText: _.errorIdentificador,
        );
      },
    );
  }

  Widget _builTelefono() {
    return GetBuilder<CaracterizacionFrMfSvProductorController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 32,
          onChanged: (valor) {
            _.setTelefono = valor;
          },
          label: 'Número de teléfono',
          errorText: _.errorTelefono,
        );
      },
    );
  }
}

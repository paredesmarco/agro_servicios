import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_cultivo_controller.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/utils/catalogos/catalogos_trampas_mf_sv.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CaracterizacionFrMfSvPaso3 extends StatefulWidget {
  const CaracterizacionFrMfSvPaso3({Key? key}) : super(key: key);

  @override
  State<CaracterizacionFrMfSvPaso3> createState() =>
      _CaracterizacionFrMfSvPaso3State();
}

class _CaracterizacionFrMfSvPaso3State extends State<CaracterizacionFrMfSvPaso3>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CuerpoFormularioTabPage(
      children: <Widget>[
        const NombreSeccion(etiqueta: 'Descripción del cultivo'),
        _buildEspecie(),
        _buildVariedad(),
        _buildArea(),
        _buildObservaciones(),
      ],
    );
  }

  Widget _buildEspecie() {
    return GetBuilder<CaracterizacionFrMfSvCultivoController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          label: 'Especie',
          lista: CatalogoTrampasMfSv().getEspecieLista(),
          errorText: _.errorEspecie,
          onChange: (valor) => _.setEspecie = valor,
        );
      },
    );
  }

  Widget _buildVariedad() {
    return GetBuilder<CaracterizacionFrMfSvCultivoController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 250,
          onChanged: (valor) => _.setVariedad = valor,
          label: 'Variedad',
          errorText: _.errorVariedad,
        );
      },
    );
  }

  Widget _buildArea() {
    return GetBuilder<CaracterizacionFrMfSvCultivoController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 10,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (valor) => _.setArea = valor,
          label: 'Área de producción (ha)',
          errorText: _.errorAreaProduccion,
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
        );
      },
    );
  }

  Widget _buildObservaciones() {
    return CampoTexto(
      maxLength: 256,
      onChanged: (valor) => Get.find<CaracterizacionFrMfSvCultivoController>()
          .setObservacion = valor,
      label: 'Observaciones',
    );
  }
}

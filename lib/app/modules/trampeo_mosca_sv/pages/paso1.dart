import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_pasos_controller.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/widgets/boton_trampa.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrampeoMfPaso1 extends StatefulWidget {
  const TrampeoMfPaso1({Key? key}) : super(key: key);

  @override
  State<TrampeoMfPaso1> createState() => _TrampeoMfPaso1State();
}

class _TrampeoMfPaso1State extends State<TrampeoMfPaso1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Medidas().init(context);
    return Column(
      children: [
        Espaciador(
          alto: altoPantalla * 0.02,
        ),
        const Text(
          'Datos de la Trampa',
          style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
        ),
        const Espaciador(alto: 15),
        GetBuilder<TrampeoMfSvTrampasController>(
          id: 'listaTrampa',
          builder: (_) {
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0.0),
                physics: const BouncingScrollPhysics(),
                itemCount: _.trampas.length,
                itemBuilder: (context, index) {
                  return BotonTrampa(
                    codigoTrampa: _.trampas[index].codigoTrampa!,
                    mensaje: 'Acciones',
                    index: index,
                    actualizado: _.trampas[index].actualizado,
                    activado: _.trampas[index].activo,
                    llenado: _.trampas[index].llenado,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

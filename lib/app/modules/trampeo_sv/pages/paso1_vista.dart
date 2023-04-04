import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/data/models/trampeo_sv/trampas_modelo.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/widgets/boton_trampa.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class DatosTrampa extends StatefulWidget {
  const DatosTrampa({super.key});
  @override
  State<StatefulWidget> createState() => _DatosTrampaState();
}

class _DatosTrampaState extends State<DatosTrampa>
    with AutomaticKeepAliveClientMixin {
  _DatosTrampaState();

  @override
  void initState() {
    super.initState();
    final p = context.read<TrampeoBloc>();
    p.getTrampasFiltradas();
    p.generarIdTablet();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Medidas().init(context);
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Column(
      children: [
        Espaciador(
          alto: altoPantalla * 0.02,
        ),
        const Text(
          'Datos de la Trampass',
          style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
        ),
        const Espaciador(alto: 15),
        Selector<TrampeoBloc, Tuple3<List<Trampas>, int, int>>(
          selector: (_, provider) => Tuple3(
              provider.listaTrampas,
              provider.cantidadTrampasLlenadas,
              provider.cantidadTrampasInactivadas),
          builder: (_, data, w) {
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0.0),
                physics: const BouncingScrollPhysics(),
                itemCount: provider.listaTrampas.length,
                itemBuilder: (context, index) {
                  return BotonTrampa(
                    codigoTrampa: provider.listaTrampas[index].codigotrampa!,
                    mensaje: 'Acciones',
                    index: index,
                    actualizado: provider.listaTrampas[index].actualizado,
                    activado: provider.listaTrampas[index].activo,
                    llenado: provider.listaTrampas[index].llenado,
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

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_ubicacion.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/pages/nuevo_vigilancia_vista.dart';
import 'package:agro_servicios/app/modules/vigilancia_sv/pages/sincronizacion_vigilancia_sv_vista.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class Vigilancia extends StatefulWidget {
  const Vigilancia({super.key});
  @override
  State<StatefulWidget> createState() => _VigilanciaState();
}

class _VigilanciaState extends State<Vigilancia> {
  FocusNode nodo1 = FocusNode();
  FocusNode nodo2 = FocusNode();

  @override
  void initState() {
    final p = context.read<UbicacionBloc>();
    final p2 = context.read<OrdenLaboratorioSvBloc>();
    p.getProvinciaSincronizacion();
    p.encerarSincronizacion();
    p2.limpiarOrdenes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerLogin = Provider.of<LoginBloc>(context, listen: false);
    Medidas().init(context);
    // return Selector<TrampeoBloc, int>(
    //   selector: (_, _provider) => _provider.cantidadTrampasSincronizadas,
    //   builder: (_, data, w) {
    if (providerLogin.getOnline) {
      return const FormularioSincronizacionVigilancia();
    } else {
      return const FormularioNuevaVigilanciaVista();
    }
    //   },
    // );
  }
}

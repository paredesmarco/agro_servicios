import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/modules/trampeo_sv/pages/sincronizacion_vista.dart';
import 'package:agro_servicios/app/modules/trampeo_sv/pages/lugar_trampa_vista.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class RegistroTrampeo extends StatefulWidget {
  const RegistroTrampeo({super.key});
  @override
  State<StatefulWidget> createState() => _RegistroTrampeoState();
}

class _RegistroTrampeoState extends State<RegistroTrampeo> {
  FocusNode nodo1 = FocusNode();
  FocusNode nodo2 = FocusNode();
  //final TextEditingController _usuarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final p = context.read<TrampeoBloc>();

      p.getProvincias();
      p.getCantidadTrampasSincronizadas();
      p.limpiarProvincia();
      p.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerLogin = Provider.of<LoginBloc>(context, listen: false);
    Medidas().init(context);
    return Selector<TrampeoBloc, int?>(
      selector: (_, provider) => provider.cantidadTrampasSincronizadas,
      builder: (_, data, w) {
        if (providerLogin.getOnline) {
          return const FormularioSincronizacionTrampasVigilancia();
        } else {
          return const FormularioLugarTrampaVista();
        }
        // if (data == 0 || data == null) {
        //   return FormularioSincronizacionTrampasVigilancia();
        // }
        // return FormularioLugarTrampaVista();
      },
    );
  }
}

import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/modules/inicial/informacion_inicial.dart';
import 'package:agro_servicios/app/modules/login/login.dart';
import 'package:agro_servicios/app/modules/registroInformacion/registroinformacion.dart';

class RutaHome extends StatefulWidget {
  const RutaHome({super.key});
  @override
  State<StatefulWidget> createState() => _RutaHomeState();
}

class _RutaHomeState extends State<RutaHome> {
  @override
  void initState() {
    super.initState();
    final u = context.read<LoginBloc>();
    u.obtenerUsuarioLogueado();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<LoginBloc, UsuarioModelo?>(
      selector: (_, provider) => provider.listaUsuario,
      builder: (_, data, w) {
        data = null;
        if (data != null) {
          return const Login();
        } else {
          return DatosRegistroPaso1();
          //return const InformacionInicial();
        }
      },
    );
  }
}

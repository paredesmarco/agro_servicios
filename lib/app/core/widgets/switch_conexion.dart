import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SwitchConexion extends StatefulWidget {
  final Function limpiarUsuario;
  const SwitchConexion({super.key, required this.limpiarUsuario});

  @override
  State<StatefulWidget> createState() => _SwitchConexionState();
}

class _SwitchConexionState extends State<SwitchConexion> {
  bool tipoConexion = true;
  Color colorOnline = Colors.grey.shade700;
  Color colorOffline = Colors.white;
  bool online = true;
  final ctrLogin = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    LoginBloc providerLogin = Provider.of<LoginBloc>(context, listen: false);
    return Container(
      width: getProporcionAnchoPantalla(250),
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xff09c273),
      ),
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            online = !online;
            Get.find<LoginController>().setOnline = online;
            providerLogin.setOnline = online;
            providerLogin.setCampoActivo = online;
            widget.limpiarUsuario();
            if (online) {
              ctrLogin.setTipoIngreso = 'usuario';
              providerLogin.setTipoIngreso = 'usuario';
              providerLogin.setMensajeTipoLogin = 'Usuario y Contraseña';
              providerLogin.setMensajeCampoClave = 'Contraseña';
              providerLogin.setCampoActivo = true;
              providerLogin.setMargenBar = 20.0;
            } else {
              ctrLogin.setTipoIngreso = 'pin';
              providerLogin.setTipoIngreso = 'pin';
              providerLogin.setMensajeTipoLogin = 'PIN';
              providerLogin.setMensajeCampoClave = 'PIN';
              providerLogin.setCampoActivo = false;
              providerLogin.setMargenBar = 50.0;
            }
            setState(() {
              tipoConexion = !tipoConexion;
              if (tipoConexion) {
                colorOnline = Colors.grey.shade700;
                colorOffline = Colors.white;
              } else {
                colorOnline = Colors.white;
                colorOffline = Colors.grey.shade700;
              }
            });
          },
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                left: tipoConexion ? 0.5 : getProporcionAnchoPantalla(119.5),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget childs, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: childs,
                    );
                  },
                  child: tipoConexion
                      ? Container(
                          margin: const EdgeInsets.all(2.5),
                          width: getProporcionAnchoPantalla(125),
                          height: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(2.5),
                          width: getProporcionAnchoPantalla(125),
                          height: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text('Online',
                          style: TextStyle(
                            color: colorOnline,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Offline',
                        style: TextStyle(
                            color: colorOffline, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

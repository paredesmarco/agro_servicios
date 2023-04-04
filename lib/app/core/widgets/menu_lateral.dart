import 'package:agro_servicios/app/bloc/bloc_aplicaciones.dart';
import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';

class MenuLateral extends StatelessWidget {
  MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginProvider =
        Provider.of<LoginBloc>(context, listen: false);
    final trampasProvider = Provider.of<TrampeoBloc>(context, listen: false);

    final aplicacionesProvider =
        Provider.of<AplicacionesBloc>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            text: 'Generar Pin',
            style: const TextStyle(color: Colors.black54),
            icon: const Icon(Icons.lock_outline, color: Colors.black54),
            onTap: () {
              Alert(
                style: alertStyle,
                context: context,
                title: "Generar Pin de Acceso",
                desc:
                    "El nuevo pin de acceso será enviado a su correo electrónico registrado en el Sistema GUIA, el mismo que servirá únicamente para este dispositivo y tendrá una vigencia de 5 días",
                buttons: [
                  DialogButton(
                    color: Colors.redAccent,
                    onPressed: () => Get.back(),
                    width: 120,
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  DialogButton(
                    color: const Color(0xff09c273),
                    onPressed: () async {
                      Get.back();
                      _mostrarModalBottomSheet(context);
                      final controler = Get.find<LoginController>();
                      await aplicacionesProvider.getPin(
                          controler.usuarioModelo!.identificador,
                          controler.usuarioModelo!.tipo);
                      await loginProvider.obtenerUsuarioLogueado();
                      await Future.delayed(const Duration(seconds: 4));
                      Get.back();
                      aplicacionesProvider.reset();
                    },
                    width: 120,
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )
                ],
              ).show();
            },
          ),
          const Divider(),
          _createDrawerItem(
              icon: const Icon(Icons.exit_to_app, color: Colors.black54),
              text: 'Cerrar Sesión',
              style: const TextStyle(color: Colors.black54),
              onTap: () {
                loginProvider.setOnline = true;
                loginProvider.setCampoActivo = true;
                loginProvider.setTipoIngreso = 'usuario';
                Get.find<LoginController>().setTipoIngreso = 'usuario';
                loginProvider.setMensajeTipoLogin = 'Usuario y Contraseña';
                loginProvider.setMensajeCampoClave = 'Contraseña';
                loginProvider.setMargenBar = 20.0;
                loginProvider.obtenerUsuarioLogueado();
                Navigator.pushReplacementNamed(context, 'login');
                Get.find<LoginController>().setOnline = true;
              }),
          const Divider(),
          _createDrawerItem(
            icon: const Icon(Icons.group_outlined, color: Colors.black54),
            text: 'Cambiar Usuario',
            style: const TextStyle(color: Colors.black54),
            onTap: () {
              Alert(
                style: alertStyle,
                context: context,
                title: "Cambiar Usuario",
                desc:
                    "Se borrarán todos tus datos de usuario para poder acceder con uno nuevo.",
                buttons: [
                  DialogButton(
                    color: Colors.redAccent,
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  DialogButton(
                    color: const Color(0xff09c273),
                    onPressed: () {
                      loginProvider.cerrarSesion();
                      trampasProvider.limpiarTrampas();
                      Get.find<LoginController>().setTipoIngreso = 'usuario';
                      Get.find<LoginController>().setOnline = true;
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('login', (route) => false);
                    },
                    width: 120,
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  )
                ],
              ).show();
            },
          ),
          ListTile(
            title: const Text(
              'Version $SCHEMA_VERSION',
              style: TextStyle(color: Colors.black54),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  final AlertStyle alertStyle = AlertStyle(
    animationType: AnimationType.fromBottom,
    descStyle: const TextStyle(fontSize: 14),
    descTextAlign: TextAlign.center,
    animationDuration: const Duration(milliseconds: 300),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    alertAlignment: Alignment.center,
  );

  Widget _createHeader(context) {
    return SizedBox(
      height: 200,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('img/logo.png'), scale: 6.0),
          // image: DecorationImage(
          //     image: AssetImage('img/logo_blanco.png'), scale: 6),

          // gradient: LinearGradient(
          //   colors: [Colores.gradient1, Colores.gradient2],
          // ),
          // color: Colors.white,
        ),
        child: Stack(children: <Widget>[
          Consumer<LoginBloc>(builder: (_, provider, w) {
            // final List? nombre = _provider.listaUsuario?.nombre?.split(' ');
            return Container(
              margin: const EdgeInsets.only(top: 100),
              child: Center(
                child: Text(
                  'AGRO Servicios',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700),
                ),
              ),
            );
          }),
        ]),
      ),
    );
  }

  Widget _createDrawerItem({
    required Icon icon,
    required String text,
    GestureTapCallback? onTap,
    TextStyle? style,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: style,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  _mostrarModalBottomSheet(context) {
    mostrarModalBottomSheet(
        titulo: 'Generando PIN',
        icono: _buildIconoModal(context),
        mensaje: _buildMensajeModal(context));
  }

  Widget _buildIconoModal(context) {
    final AplicacionesBloc aplicacionesProvider =
        Provider.of<AplicacionesBloc>(context, listen: false);

    return Consumer<AplicacionesBloc>(
      builder: (_, provider, widget) {
        if (!aplicacionesProvider.estaValidando) return Modal.cargando();

        if (aplicacionesProvider.estadoGeneracionPin == 'exito') {
          return Modal.iconoValido();
        } else {
          return Modal.iconoError();
        }
      },
    );
  }

  Widget _buildMensajeModal(context) {
    final AplicacionesBloc aplicacionesProvider =
        Provider.of<AplicacionesBloc>(context, listen: false);

    return Consumer<AplicacionesBloc>(
      builder: (_, provider, widget) {
        if (aplicacionesProvider.mensajeValidacion != '') {
          return Modal.mensajeSincronizacion(
              mensaje: aplicacionesProvider.mensajeValidacion!);
        }

        return Modal.mensajeSincronizacion(mensaje: 'Generarn Pin');
      },
    );
  }
}

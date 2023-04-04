import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/boton.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Modal extends StatelessWidget {
  final String titulo;
  final Widget mensaje;
  final Widget icono;
  final double alto;
  final VoidCallback? bajarDatos;
  final bool mostrarBotones;
  const Modal({
    required this.titulo,
    required this.mensaje,
    required this.icono,
    Key? key,
    this.alto = 200,
    this.bajarDatos,
    this.mostrarBotones = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double altura = orientacion.index == 0 ? alto : (alto + 20);
    Medidas().init(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: orientacion.index == 0 ? 0 : anchoPantalla * 0.2),
        height: altura,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        minWidth: 100,
                        maxWidth: orientacion.index == 0
                            ? anchoPantalla * 0.7
                            : anchoPantalla * 0.37),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              titulo,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: orientacion.index == 0 ? 5 : 0,
                              horizontal: orientacion.index == 0
                                  ? anchoPantalla * 0.02
                                  : anchoPantalla * 0.02),
                          child: const Divider(
                            thickness: 1,
                            color: Colores.divider,
                          ),
                        ),
                        mensaje,
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      icono,
                    ],
                  )
                ],
              ),
              Visibility(
                visible: mostrarBotones,
                child: Column(
                  children: [
                    Espaciador(
                      alto: orientacion.index == 0 ? 20 : 10,
                    ),
                    const _BotonAceptar(),
                    Visibility(
                      visible: orientacion.index == 0 ? false : true,
                      child: const Espaciador(alto: 5),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static RoundedRectangleBorder borde() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
    );
  }

  static Widget cargando() {
    return Padding(
      padding: EdgeInsets.only(right: orientacion.index == 0 ? 0 : 0),
      child: const SizedBox(
        width: 83,
        height: 83,
        child: Center(
          child: SizedBox(
            width: 65,
            height: 65,
            child: CircularProgressIndicator(
              color: Color(0XFF1ABC9C),
              strokeWidth: 5.0,
            ),
          ),
        ),
      ),
    );
  }

  static Widget iconoValido() {
    return const Icon(
      Icons.check_circle_outline,
      size: 84.0,
      color: Colors.lightGreen,
    );
  }

  static Widget iconoError() {
    return const Icon(
      Icons.error_outline,
      size: 84.0,
      color: Colors.redAccent,
    );
  }

  static Widget iconoAdvertencia() {
    return const Icon(
      Icons.warning_amber_rounded,
      size: 96,
      color: Colores.warning,
    );
  }

  static Widget mensajeSincronizacion(
      {required String mensaje, double? fontSize}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: altoPantalla * 0.15),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Text(
                mensaje,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize ?? 14,
                    fontStyle: FontStyle.normal,
                    color: Colores.divider),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget mensajeSinDatos({required String mensaje}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: altoPantalla * 0.15),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Text(
                mensaje,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: Colores.divider),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BotonAceptar extends StatelessWidget {
  const _BotonAceptar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Boton(
      ancho: orientacion.index == 0 ? anchoPantalla * 0.3 : anchoPantalla * 0.2,
      texto: 'Aceptar',
      color: Colores.primaryColor,
      funcion: () {
        Get.back();
      },
    );
  }
}

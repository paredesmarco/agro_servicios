import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/controllers/sincronizacion_controller.dart';
import 'package:agro_servicios/app/core/widgets/boton.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CuerpoFormularioSincronizacion extends StatelessWidget {
  final String titulo;
  final ContenidoTabSincronizacion widgetsBajarDatos;
  final ContenidoTabSincronizacion widgetsSubirDatos;

  final SincronizacionController controlador =
      Get.find<SincronizacionController>();

  CuerpoFormularioSincronizacion({
    super.key,
    required this.titulo,
    required this.widgetsBajarDatos,
    required this.widgetsSubirDatos,
  });
  @override
  Widget build(BuildContext context) {
    Medidas().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          titulo,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
        ),
        backgroundColor: Colors.transparent, // Colors.white.withOpacity(0.1),
        elevation: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colores.gradient1, Colores.gradient2],
              // colors: [Color(0xFFF0099393), Color(0xFFF1f5971)],
            ),
          ),
          child: Column(
            children: <Widget>[
              Espaciador(alto: MediaQuery.of(context).padding.top),
              const Espaciador(alto: 48),
              SizedBox(
                height: orientacion.index == 0
                    ? altoPantalla * 0.250
                    : altoPantalla * 0.09,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: orientacion.index == 0 ? true : false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Espaciador(alto: 15),
                          Center(
                            child: SvgPicture.asset(
                              'img/logo_blanco.svg',
                              color: Colors.white,
                              semanticsLabel: 'Agrocalidad',
                              height: altoPantalla * 0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              _BajarDatos(),
                              _SubirDatos(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: controlador.pageController,
                    children: [
                      widgetsBajarDatos,
                      widgetsSubirDatos,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget informacionBajarDatos({String? texto}) {
    return Column(
      children: [
        const Espaciador(
          alto: 30,
        ),
        const Divider(
          color: Colores.divider,
          height: 3,
        ),
        const Espaciador(
          alto: 10,
        ),
        Text(
          texto ??
              'Seleccione al menos una provincia y sincronice la información, para poder utilizar el formulario de modo Offline',
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colores.divider,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  static Widget informacionSubirDatos(Widget texto) {
    return Column(
      children: [
        SvgPicture.asset(
          'img/cloud_sync.svg',
          color: Colors.blueGrey,
          semanticsLabel: 'Agrocalidad',
          height: altoPantalla * 0.2,
        ),
        const Espaciador(
          alto: 30,
        ),
        const Divider(
          color: Colores.divider,
          height: 3,
        ),
        const Espaciador(
          alto: 10,
        ),
        texto
      ],
    );
  }

  static Widget textoMensajes(String mensaje) {
    return Text(
      mensaje,
      style: const TextStyle(
        fontFamily: 'Poppins',
        color: Colores.divider,
        fontSize: 12,
      ),
    );
  }

  static Widget botonSincronizar(VoidCallback funcion, {String? texto}) {
    return Boton(
      ancho: anchoPantalla * 0.4,
      texto: texto ?? 'Sincronizar',
      color: Colores.primaryColor,
      funcion: funcion,
    );
  }
}

class _BajarDatos extends StatelessWidget {
  const _BajarDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);

    return GetBuilder<SincronizacionController>(builder: (_) {
      return GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 35,
          width: anchoPantalla * 0.43,
          decoration: BoxDecoration(
            color: _.colorBajarDatos,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(width: 0, color: _.colorBajarDatos),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bajar datos',
                  style: TextStyle(color: _.colorSubirDatos),
                ),
                const Espaciador(ancho: 5),
                Icon(
                  Icons.cloud_download_outlined,
                  color: _.colorSubirDatos,
                )
              ],
            ),
          ),
        ),
        onTap: () {
          _.cambiarPagina(0);
        },
      );
    });
  }
}

class _SubirDatos extends StatelessWidget {
  const _SubirDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);

    return GetBuilder<SincronizacionController>(
      builder: (_) {
        return GestureDetector(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 35,
            width: anchoPantalla * 0.43,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: _.colorSubirDatos,
              border: Border.all(width: 0, color: _.colorSubirDatos),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subir datos',
                    style: TextStyle(color: _.colorBajarDatos),
                  ),
                  const Espaciador(ancho: 5),
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: _.colorBajarDatos,
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            _.cambiarPagina(1);
          },
        );
      },
    );
  }
}

class ContenidoTabSincronizacion extends StatefulWidget {
  final List<Widget>? widgets;

  const ContenidoTabSincronizacion({
    super.key,
    this.widgets,
  });

  @override
  State<StatefulWidget> createState() => _ContenidoTabSincronizacionState();
}

class _ContenidoTabSincronizacionState extends State<ContenidoTabSincronizacion>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: anchoPantalla * 0.1, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.widgets ?? []),
        ),
      ),
    );
  }
}

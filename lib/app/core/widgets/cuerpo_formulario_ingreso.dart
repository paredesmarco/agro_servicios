import 'package:flutter/material.dart';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';

class CuerpoFormularioIngreso extends StatelessWidget {
  final String titulo;
  final List<Widget>? widgets;
  final EdgeInsets? edgets;
  final Widget? botonFormulario;
  final FloatingActionButton? fab;
  final bool appBarExtendido;

  const CuerpoFormularioIngreso({
    Key? key,
    required this.titulo,
    this.widgets,
    this.edgets,
    this.botonFormulario,
    this.fab,
    this.appBarExtendido = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appbar;

    if (appBarExtendido == true) {
      appbar = AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
    } else {
      appbar = AppBar(
        title: Text(titulo),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        floatingActionButton: fab,
        extendBodyBehindAppBar: true,
        appBar: appbar,
        body: SizedBox(
          height: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colores.gradient1, Colores.gradient2],
              ),
            ),
            child: Column(
              children: <Widget>[
                Espaciador(
                  alto: MediaQuery.of(context).padding.top,
                ),
                const Espaciador(
                  alto: 55,
                ),
                Visibility(
                  visible: appBarExtendido,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: edgets ??
                                  EdgeInsets.only(
                                    left: anchoPantalla * 0.04,
                                    right: anchoPantalla * 0.04,
                                  ),
                              child: Column(
                                children: [
                                  const Espaciador(alto: 5),
                                  Column(
                                    children: widgets ?? [Container()],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        botonFormulario ?? Container(),
                        if (botonFormulario.runtimeType != BotonPlano)
                          const Espaciador(alto: 15)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

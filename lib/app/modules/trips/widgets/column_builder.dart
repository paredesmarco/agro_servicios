import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  final List<Widget>? widgets;
  final EdgeInsets? edgets;
  final BotonPlano? botonFormulario;

  const ColumnBuilder(
      {Key? key, this.widgets, this.edgets, this.botonFormulario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                children: widgets ?? [Container()],
              ),
            ),
          ),
        ),
        botonFormulario ?? Container(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BotonFabCoordenadas extends StatefulWidget {
  final RxBool validacion;
  final VoidCallback? funcion;

  const BotonFabCoordenadas(
      {required this.validacion, this.funcion, super.key});

  @override
  State<BotonFabCoordenadas> createState() => _BotonFabCoordenadasState();
}

class _BotonFabCoordenadasState extends State<BotonFabCoordenadas> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fabGps',
      tooltip: 'Obtener coordenadas',
      onPressed: widget.funcion,
      child: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget childs, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: childs);
          },
          child: !widget.validacion.value
              ? const FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: Colors.white,
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}

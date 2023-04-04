import 'package:flutter/material.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContenedorSinRegistros extends StatelessWidget {
  const ContenedorSinRegistros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.fileCircleExclamation,
              color: Colors.grey.shade300,
              size: 180,
            ),
            const Espaciador(alto: 15),
            const Text(
              'No existen registros sincronizados',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

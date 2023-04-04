import 'dart:io';

import 'package:flutter/material.dart';

import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:local_auth/local_auth.dart';

class BotonPlano extends StatefulWidget {
  final String texto;
  final Color color;
  final VoidCallback funcion;
  final Icon? icono;

  const BotonPlano(
      {Key? key,
      required this.texto,
      required this.color,
      required this.funcion,
      this.icono})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BotonPlanoState();
}

class _BotonPlanoState extends State<BotonPlano> {
  bool _necesitaEspacio = false;

  @override
  void initState() {
    _tipoBiometricoDisponibles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: widget.color,
            shape: const RoundedRectangleBorder()),
        onPressed: widget.funcion,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.texto,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                if (widget.icono != null)
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      widget.icono ?? Container(),
                    ],
                  )
              ],
            ),
            if (_necesitaEspacio)
              Container(
                height: 8,
              )
          ],
        ),
      ),
    );
  }

  _tipoBiometricoDisponibles() async {
    final LocalAuthentication auth = LocalAuthentication();
    List<BiometricType> a = await auth.getAvailableBiometrics();
    if (Platform.isIOS) {
      if (a.contains(BiometricType.face)) {
        _necesitaEspacio = true;
        setState(() {});
      }
    }
  }
}

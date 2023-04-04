import 'package:flutter/material.dart';

typedef OnPressCalback = Function(dynamic valor);

class BotonFoto extends StatelessWidget {
  final OnPressCalback onPress;

  const BotonFoto({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // splashColor: Color(0xFFCDEBFF),
      // highlightColor: Color(0x5aCDEBFF),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        side: const BorderSide(color: Color(0xFF3498DB), width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.camera_alt,
            color: Color(0xFF3498DB),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Añadir Imagen',
            style: TextStyle(color: Color(0xFF3498DB)),
          ),
        ],
      ),
      onPressed: () async {
        await onPress(null);
        // _bottomSheet(context);
      },
    );
  }
}

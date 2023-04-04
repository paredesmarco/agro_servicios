import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

typedef OnTapCallback = Function(bool valor);

class VistaImagen extends StatelessWidget {
  ///
  /// informacion de la clase
  /// Retorna true si se debe eliminar la imagen
  static const colotTexto = Brightness.light;

  final File imagen;
  final OnTapCallback? onTap;

  const VistaImagen({Key? key, required this.imagen, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f8f8),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.grey),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Eliminar Imagen',
            onPressed: () {
              _bottomSheet(context);
            },
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'imgprevia',
          child: InteractiveViewer(child: Image.file(imagen)),
        ),
      ),
    );
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SafeArea(
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.red),
            child: ClipRRect(
              // borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: Container(
                color: Colors.white,
                child: Wrap(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Desea eliminar la imagen?',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          child: const Center(
                            child: Text(
                              'Si',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF3498DB),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          onTap!(true);

                          Get.back();
                          Get.back();
                        },
                      ),
                    ),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          child: const Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF3498DB),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

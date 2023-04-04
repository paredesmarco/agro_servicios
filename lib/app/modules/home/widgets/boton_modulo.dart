import 'package:flutter/material.dart';

import 'package:agro_servicios/app/data/models/aplicaciones/aplicaciones_modelo.dart';
import 'package:agro_servicios/app/utils/color_hexa_a_int.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:get/get.dart';

class BotonModulo extends StatelessWidget {
  final AplicacionesModelo aplicacion;

  const BotonModulo({super.key, required this.aplicacion});

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return GestureDetector(
      onTap: () {
        Get.toNamed(aplicacion.vista!);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff878686).withOpacity(0.04),
                offset: const Offset(5.0, 5.0),
                spreadRadius: 0.1,
                blurRadius: 5.0)
          ],
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
            height: 80.0,
            width: getProporcionAnchoPantalla(350),
            child: Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            hexToColor(aplicacion.colorInicio!),
                            hexToColor(aplicacion.colorFin!)
                          ]),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: const Center(
                    child: Icon(
                      Icons.assignment_turned_in_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _buildTitulo(aplicacion.nombre ?? ''),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39675e)),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(aplicacion.descripcion ?? '',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13.0),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xff1abc9c),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTitulo(String titulo) {
    String tituloFinal;
    if (titulo.length > 80) {
      tituloFinal = '${titulo.substring(0, 75)}...';
    } else {
      tituloFinal = titulo;
    }
    return tituloFinal;
  }
}

class BotonModulo2 extends StatelessWidget {
  final Color? colorInicio;
  final Color? colorFinal;

  const BotonModulo2({super.key, this.colorInicio, this.colorFinal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Color(0XFFFE9E9E9)),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              //color: colorFinal.withOpacity(0.1),
              offset: const Offset(5.0, 5.0),
              spreadRadius: 1.0,
              blurRadius: 5.0)
        ],
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: SizedBox(
          height: 80.0,
          width: getProporcionAnchoPantalla(340),
          child: Row(
            children: [
              // Container(
              //   height: 80.0,
              //   width: 3.0,
              //   color: colorFinal,
              // ),
              const SizedBox(
                width: 5.0,
              ),
              SizedBox(
                height: 50.0,
                width: 50.0,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [colorInicio!, colorFinal!]),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Center(
                          child: Icon(
                            Icons.print,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 14.0,
                        width: 14.0,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.lightGreen, Colors.green]),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _buildTitulo(
                          'Programación Anual Presupuestaria - Plan Anual de Contratación'),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          //fontWeight: FontWeight.bold,
                          color: Color(0xff39675e)
                          //fontSize: 18.0,
                          ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Fiscalizar GUIAS de movilizacion de porcinos',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13.0),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xff1abc9c),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitulo(String titulo) {
    String tituloFinal;
    if (titulo.length > 80) {
      tituloFinal = '${titulo.substring(0, 75)}...';
    } else {
      tituloFinal = titulo;
    }
    return tituloFinal;
  }
}

class BotonModulo3 extends StatelessWidget {
  final Color? colorInicio;
  final Color? colorFinal;

  const BotonModulo3({super.key, this.colorInicio, this.colorFinal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
              //color: Colors.black12.withOpacity(0.1),
              color: colorFinal!.withOpacity(0.1),
              offset: const Offset(0.0, 0.0),
              spreadRadius: 5.0,
              blurRadius: 5.0)
        ],
        color: const Color(0xff435055),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: SizedBox(
          height: 80.0,
          width: getProporcionAnchoPantalla(340),
          child: Row(
            children: [
              // Container(
              //   height: 80.0,
              //   width: 3.0,
              //   color: colorFinal,
              // ),
              const SizedBox(
                width: 5.0,
              ),
              SizedBox(
                //color: Colors.white,
                height: 50.0,
                width: 50.0,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [colorInicio!, colorFinal!]),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Center(
                          child: Icon(
                            Icons.print,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 12.0,
                        width: 12.0,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.lightGreen, Colors.green]),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Fiscalizacion',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('Fiscalizar GUIAS de movilizacion de porcinoss',
                          style: TextStyle(color: Colors.white70),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xff1abc9c),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

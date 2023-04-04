import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BotonTrampa extends StatelessWidget {
  final String codigoTrampa;
  final String mensaje;
  final int index;
  final bool? actualizado;
  final bool? activado;
  final bool? llenado;
  const BotonTrampa(
      {Key? key,
      required this.codigoTrampa,
      required this.mensaje,
      required this.index,
      this.actualizado,
      this.activado,
      this.llenado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          left: anchoPantalla * 0.04, right: anchoPantalla * 0.04, bottom: 10),
      child: InkWell(
        onTap: () {
          provider.setTrampaSeleccionada = index;
          Get.toNamed(Rutas.TRAMPEOVFINGRESO,
              arguments: <String, dynamic>{'index': codigoTrampa});
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: const Color(0xffdfdfdf).withOpacity(0.5), width: 0.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffdfdfdf).withOpacity(0.5),
                  offset: const Offset(5.0, 5.0),
                  spreadRadius: 0.1,
                  blurRadius: 5.0)
            ],
          ),
          child: Row(
            children: [
              (actualizado == true && llenado!)
                  ? _builCheck()
                  : _buildTrampaVacia(),
              const Espaciador(ancho: 25),
              Container(
                color: Colors.blueGrey,
                height: 30,
                width: 0.3,
              ),
              const Espaciador(ancho: 25),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          codigoTrampa,
                          style: const TextStyle(color: Color(0xFF6e7579)),
                        ),
                        const Espaciador(
                          ancho: 10,
                        ),
                        if (!activado!)
                          Text(
                            'Trampa Inactiva',
                            style:
                                TextStyle(color: Colors.red[400], fontSize: 13),
                          ),
                      ],
                    ),
                    const Espaciador(
                      alto: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          mensaje,
                          style: const TextStyle(
                            color: Color(0xFFa2abae),
                            fontSize: 12,
                          ),
                        ),
                        const Espaciador(
                          ancho: 10,
                        ),
                        Container(
                          color: Colors.blueGrey,
                          height: 15,
                          width: 0.3,
                        ),
                        const Espaciador(
                          ancho: 10,
                        ),
                        activado!
                            ? _botonInactivar(context, index)
                            : _botonActivar(context, index),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 40,
                    child: Center(
                      child: Icon(Icons.chevron_right_sharp,
                          color: const Color(0xFF6e7579).withOpacity(0.5)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonInactivar(context, int? index) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
              // border: Border.all(
              //     width: 0.5, color: Color(0xFFa2abae)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              'Inactivar',
              style: TextStyle(color: Color(0xFFa2abae), fontSize: 11),
            ),
          ),
        ),
        onTap: () {
          provider.setTrampaSeleccionada = index;
          provider.inactivarTrampa(index);
        },
      ),
    );
  }

  Widget _botonActivar(context, int? index) {
    final provider = Provider.of<TrampeoBloc>(context, listen: false);
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
              // border: Border.all(
              //     width: 0.5, color: Color(0xFFa2abae)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              'Activar',
              style: TextStyle(color: Color(0xFFa2abae), fontSize: 11),
            ),
          ),
        ),
        onTap: () {
          provider.setTrampaSeleccionada = index;
          provider.activarTrampa(index);
        },
      ),
    );
  }

  Widget _builCheck() {
    return Row(
      children: const [
        Espaciador(ancho: 21),
        Icon(
          Icons.check_circle,
          size: 27,
          color: Color(0xff09c273),
        ),
      ],
    );
  }

  Widget _buildTrampaVacia() {
    return Row(
      children: [
        const Espaciador(ancho: 25),
        Container(
          height: 23,
          width: 23,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: const Color(0xFFDCDCDC),
            ),
          ),
        ),
      ],
    );
  }
}

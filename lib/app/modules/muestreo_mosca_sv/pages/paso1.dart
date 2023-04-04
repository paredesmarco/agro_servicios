import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/vista_previa_imagen.dart';
import 'package:agro_servicios/app/modules/muestreo_mosca_sv/controllers/muestreo_mf_sv_ubicacion_controller.dart';
import 'package:agro_servicios/app/core/widgets/boton_foto.dart';
import 'package:agro_servicios/app/core/widgets/camara.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class MuestreoMfSvPaso1 extends StatefulWidget {
  const MuestreoMfSvPaso1({Key? key}) : super(key: key);

  @override
  State<MuestreoMfSvPaso1> createState() => _MuestreoMfSvPaso1State();
}

class _MuestreoMfSvPaso1State extends State<MuestreoMfSvPaso1>
    with AutomaticKeepAliveClientMixin {
  final controlador = Get.find<MuestreoMfSvUbicacionController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CuerpoFormularioTabPage(
      children: <Widget>[
        const NombreSeccion(etiqueta: 'Ubicación'),
        Obx(() => CampoDescripcion(
            etiqueta: 'Provincia', valor: controlador.provincia.value)),
        _buildCantonces(),
        _buildParroquia(),
        _buildSitio(),
        _buildCoordenadaX(),
        _buildCoordenadaY(),
        _buildCoordenadaZ(),
        _buildEnvioMuestra(),
        _buildFoto(),
        const Espaciador(
          alto: 80,
        )
      ],
    );
  }

  Widget _buildCantonces() {
    return GetBuilder<MuestreoMfSvUbicacionController>(
      id: 'idCanton',
      builder: (_) {
        return Combo(
          items: _.listaCanton.map((e) {
            return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
          }).toList(),
          label: 'Cantón',
          errorText: _.errorCanton,
          onChanged: (valor) async {
            _.setCanton(valor);
            await _.obtenerParroquia(valor);
          },
        );
      },
    );
  }

  Widget _buildParroquia() {
    return GetBuilder<MuestreoMfSvUbicacionController>(
      id: 'idParroquia',
      builder: (_) {
        return Combo(
          key: UniqueKey(),
          items: _.listaParroquia.map((e) {
            return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
          }).toList(),
          value: _.idParroquia,
          label: 'Parroquia',
          errorText: _.errorParroquia,
          onChanged: (valor) async {
            _.setParroquia(valor);
          },
        );
      },
    );
  }

  Widget _buildSitio() {
    return GetBuilder<MuestreoMfSvUbicacionController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          onChanged: (valor) => _.setSitio = valor,
          maxLength: 64,
          label: 'Sitio',
          errorText: _.errorSitio,
        );
      },
    );
  }

  Widget _buildCoordenadaX() {
    return GetBuilder<MuestreoMfSvUbicacionController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          controller: _.coordenadaXcontrolador,
          onChanged: (valor) => _.setCoordenadaX = valor,
          label: 'Coordenada X',
          errorText: _.errorCoordenadaX,
          maxLength: 32,
        );
      },
    );
  }

  Widget _buildCoordenadaY() {
    return GetBuilder<MuestreoMfSvUbicacionController>(
        id: 'idValidacion',
        builder: (_) {
          return CampoTexto(
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
            textInputFormatter: [
              ComaTextInputFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            controller: _.coordenadaYcontrolador,
            onChanged: (valor) => _.setCoordenadaY = valor,
            label: 'Coordenada Y',
            errorText: _.errorCoordenadaY,
            maxLength: 32,
          );
        });
  }

  Widget _buildCoordenadaZ() {
    return GetBuilder<MuestreoMfSvUbicacionController>(
        id: 'idValidacion',
        builder: (_) {
          return CampoTexto(
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
            textInputFormatter: [
              ComaTextInputFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
            ],
            controller: _.coordenadaZcontrolador,
            onChanged: (valor) => _.setCoordenadaZ = valor,
            label: 'Coordenada Z',
            errorText: _.errorCoordenadaZ,
            maxLength: 32,
          );
        });
  }

  Widget _buildEnvioMuestra() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Envío muestra:', style: _labelStyle()),
          Row(
            children: [
              Radio(
                value: null,
                groupValue: null,
                onChanged: (dynamic valor) {},
              ),
              const Text('Si', style: TextStyle(color: Color(0xFF75808f))),
            ],
          )
        ],
      ),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(fontSize: 13, color: Colors.grey[500]);
  }

  Widget _buildFoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Fotografía',
            style: TextStyle(fontSize: 18, color: Color(0xFF69949C)),
          ),
        ),
        const Espaciador(alto: 20),
        const Center(child: Text('Tome una fotografía (opcional)')),
        const Espaciador(alto: 20),
        Center(
          child: GetBuilder<MuestreoMfSvUbicacionController>(
            id: 'idFoto',
            builder: (_) {
              return InkWell(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: _.imagen == null
                      ? Image.asset(_.ruta)
                      : _buildImagenPrevia(),
                ),
                onTap: () async {
                  if (_.imagen != null) {
                    await Get.to(
                      () => VistaImagen(
                        imagen: _.imagen,
                        onTap: (esEliminar) {
                          _.eliminarImagen();
                        },
                      ),
                    );
                  } else {
                    _mensajeImagen(Get.context);
                  }
                },
              );
            },
          ),
        ),
        const Espaciador(
          alto: 20,
        ),
        BotonFoto(
          onPress: (_) async {
            var xFile = await Get.to(() => const Camara());

            if (xFile != null) {
              debugPrint('path de la imagen: ${xFile.path}');
              controlador.setImagenFile = xFile.path;
            }
          },
        ),
      ],
    );
  }

  Widget _buildImagenPrevia() {
    return Hero(
      tag: 'imgprevia',
      child: Image.file(controlador.imagen),
    );
  }

  void _mensajeImagen(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sin imagen'),
          content: const Text('Primero añada una imagen'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}

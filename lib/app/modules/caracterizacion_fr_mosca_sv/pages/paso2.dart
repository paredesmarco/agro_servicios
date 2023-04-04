import 'package:agro_servicios/app/utils/coma_a_punto_regexp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_ubicacion_controller.dart';
import 'package:agro_servicios/app/core/widgets/boton_foto.dart';
import 'package:agro_servicios/app/core/widgets/camara.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_tab_page.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/core/widgets/vista_previa_imagen.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';

class CaracterizacionFrMfSvPaso2 extends StatefulWidget {
  const CaracterizacionFrMfSvPaso2({Key? key}) : super(key: key);

  @override
  State<CaracterizacionFrMfSvPaso2> createState() =>
      _CaracterizacionFrMfSvPaso2State();
}

class _CaracterizacionFrMfSvPaso2State extends State<CaracterizacionFrMfSvPaso2>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final controlador = Get.find<CaracterizacionFrMfSvUbicacionController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CuerpoFormularioTabPage(
      children: <Widget>[
        const NombreSeccion(etiqueta: 'Ubicación'),
        Obx(() => CampoDescripcion(
            etiqueta: 'Provincia', valor: controlador.provincia.value)),
        _buildCantonces(),
        _buildParroquias(),
        _buildCoordenadaX(),
        _buildCoordenadaY(),
        _buildCoordenadaZ(),
        _buildSitio(),
        const Espaciador(alto: 15),
        _buildFoto(),
        const Espaciador(alto: 80)
      ],
    );
  }

  Widget _buildCantonces() {
    return GetBuilder<CaracterizacionFrMfSvUbicacionController>(
      id: 'idValidacion',
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

  Widget _buildParroquias() {
    return GetBuilder<CaracterizacionFrMfSvUbicacionController>(
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
            // await _.obtenerParroquia(valor);
          },
        );
      },
    );
  }

  Widget _buildCoordenadaX() {
    return GetBuilder<CaracterizacionFrMfSvUbicacionController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 10,
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
        );
      },
    );
  }

  Widget _buildCoordenadaY() {
    return GetBuilder<CaracterizacionFrMfSvUbicacionController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 10,
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          textInputFormatter: [
            ComaTextInputFormatter(),
            FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
          ],
          controller: _.coordenadaYcontrolador,
          onChanged: (valor) => _.setCoordenadaY = valor,
          label: 'Coordenada Y',
          errorText: _.errorCoordenadaX,
        );
      },
    );
  }

  Widget _buildCoordenadaZ() {
    return GetBuilder<CaracterizacionFrMfSvUbicacionController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 10,
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
        );
      },
    );
  }

  Widget _buildSitio() {
    return GetBuilder<CaracterizacionFrMfSvUbicacionController>(
      id: 'idValidacion',
      builder: (_) {
        return CampoTexto(
          maxLength: 256,
          onChanged: (valor) => _.setSitio = valor,
          label: 'Sitio',
          errorText: _.errorSitio,
        );
      },
    );
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
          child: GetBuilder<CaracterizacionFrMfSvUbicacionController>(
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
              Get.find<CaracterizacionFrMfSvUbicacionController>()
                  .setImagenFile = xFile.path;
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

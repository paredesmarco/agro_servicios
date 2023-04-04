import 'package:agro_servicios/app/core/widgets/campo_descripcion_borde.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sin_registros.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_lugar_controller.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/core/widgets/boton.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/mensajes_modal_sheet.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';

class LugarTrampeoMfSv extends StatelessWidget {
  const LugarTrampeoMfSv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrampeoMfSvLugarController>(
        id: 'provincia',
        builder: (_) {
          if (_.provincia.isEmpty) {
            return const CuerpoFormularioSinRegistros(
                titulo: 'Registro de Trampeo MF');
          } else {
            return CuerpoFormularioIngreso(
              appBarExtendido: true,
              titulo: 'Registro de Trampeo MF',
              edgets: const EdgeInsets.all(0),
              widgets: [
                const Espaciador(alto: 20),
                _buildMensajeInicial(),
                const Espaciador(alto: 20),
                _buildProvinciaCombo(),
                const _Canton(),
                const _Lugar(),
                GetBuilder<TrampeoMfSvLugarController>(
                  id: 'esParroquia',
                  builder: (_) {
                    if (_.esParroquia) return _buildParroquia();
                    return _buildNumeroLugar();
                  },
                ),
                _buildSemanaActual(),
              ],
              botonFormulario: _buildBotonNuevoRegistro(),
            );
          }
        });
  }

  Widget _buildMensajeInicial() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(Get.context!).size.width * 0.04),
      child: Text(
        'Para realizar un nuevo registro de trampeo debe Ingresar los datos del lugar donde se realizará esta actividad',
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }

  String semana() {
    return '${Jiffy().week}';
  }

  Widget _buildProvinciaCombo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<TrampeoMfSvLugarController>(
          id: 'provincia',
          builder: (_) {
            return Combo(
              items: _.provincia.map((e) {
                return DropdownMenuItem(
                    value: e.idGuia, child: Text(e.nombre!));
              }).toList(),
              value: _.idProvincia,
              onChanged: (valor) {
                _.obtenerCantonesPorProvinciasSincronizadas(valor);
              },
              label: 'Provincia',
            );
          }),
    );
  }

  Widget _buildParroquia() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<TrampeoMfSvLugarController>(
        id: 'parroquia',
        builder: (_) => Combo(
          key: UniqueKey(),
          items: _.parroquia
              .map((e) => DropdownMenuItem(
                  value: e?.idGuia, child: Text(e?.nombre ?? '')))
              .toList(),
          onChanged: (valor) {
            _.setParroquia = valor;
          },
          label: 'Parroquia',
        ),
      ),
    );
  }

  Widget _buildNumeroLugar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<TrampeoMfSvLugarController>(
        id: 'numeroLugar',
        builder: (_) => Combo(
          key: UniqueKey(),
          items: _.numeroInstalacion
              .map((e) => DropdownMenuItem(
                  value: e?.numeroLugarInstalacion,
                  child: Text(e?.numeroLugarInstalacion.toString() ?? '')))
              .toList(),
          onChanged: (valor) {
            debugPrint(valor.runtimeType.toString());
            _.setNumeroInstalacion = valor;
          },
          label: 'Número lugar de instalación',
        ),
      ),
    );
  }

  Widget _buildSemanaActual() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: CampoDescripcionBorde(
        etiqueta: 'Semana',
        valor: semana(),
      ),
    );
  }

  Widget _buildBotonNuevoRegistro() {
    return Column(
      children: [
        Boton(
          alto: 37,
          texto: 'Nuevo Registro de Trampeo',
          color: const Color(0xff09c273),
          funcion: () async {
            bool valido =
                Get.find<TrampeoMfSvLugarController>().validarFormulario();
            if (valido) {
              Get.toNamed(Rutas.TRAMPEOMFSVNUEVO);
            } else {
              mostrarModalBottomSheet(
                context: Get.context!,
                titulo: SIN_DATOS_FORM,
                icono: Modal.iconoAdvertencia(),
                mensaje: Modal.mensajeSinDatos(mensaje: COMPLETAR_DATOS),
              );
              await Future.delayed(const Duration(seconds: 2));
              Get.back();
            }
          },
        ),
      ],
    );
  }
}

class _Lugar extends StatelessWidget {
  const _Lugar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<TrampeoMfSvLugarController>(
        id: 'lugar',
        builder: (_) {
          return Combo(
            key: UniqueKey(),
            items: _.lugar
                .map((e) => DropdownMenuItem(
                    value: e?.idLugarInstalacion,
                    child: Text(e?.nombreLugarInstalacion ?? '')))
                .toList(),
            onChanged: (valor) {
              _.verificarLugarInstalacion(valor);
            },
            label: 'Lugar Instalación',
          );
        },
      ),
    );
  }
}

class _Canton extends StatelessWidget {
  const _Canton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder<TrampeoMfSvLugarController>(
        id: 'canton',
        builder: (_) {
          return Combo(
            key: UniqueKey(),
            items: _.cantones.map((e) {
              return DropdownMenuItem(
                  value: e?.idGuia, child: Text(e?.nombre ?? ''));
            }).toList(),
            onChanged: (valor) {
              _.obtenerLugarInstalacion(valor);
            },
            label: 'Cantón',
          );
        },
      ),
    );
  }
}

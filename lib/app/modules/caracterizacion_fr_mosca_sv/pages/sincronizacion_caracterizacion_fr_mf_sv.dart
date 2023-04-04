import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/modules/caracterizacion_fr_mosca_sv/controllers/caracterizacion_fr_mf_sv_controller.dart';

class CaracterizacionFrMfSvSincronizacion extends StatelessWidget {
  CaracterizacionFrMfSvSincronizacion({Key? key}) : super(key: key);

  final controlador = Get.find<CaracterizacionFrMfSvController>();

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return CuerpoFormularioSincronizacion(
      titulo: 'Caracterización Frutícula',
      widgetsBajarDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildComboProvincia1(),
          _buildInformacionBajarDatos(),
          const Espaciador(alto: 40),
          _buildBotonBajarDatos(),
        ],
      ),
      widgetsSubirDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildInformacionSubirDatos(),
          const Espaciador(alto: 40),
          _buildBotonSubirDatos(),
        ],
      ),
    );
  }

  Widget _buildComboProvincia1() {
    return GetBuilder<CaracterizacionFrMfSvController>(builder: (_) {
      return Combo(
        items: _.provincia1.map((e) {
          return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
        }).toList(),
        onChanged: (valor) {
          _.setProvincia = valor;
        },
        label: 'Provincia',
      );
    });
  }

  Widget _buildInformacionBajarDatos() {
    return CuerpoFormularioSincronizacion.informacionBajarDatos();
  }

  Widget _buildBotonBajarDatos() {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        if (controlador.provinciaSincronizacion != 0) {
          await controlador.bajarDatos(
            titulo: SINCRONIZANDO_DOWN,
            mensaje: _buildMensajeModalSincronizados(),
            icono: _buildIconoModalSincronizados(),
          );
        } else {
          await controlador.sinProvincias(
            titulo: COMPLETAR_DATOS,
            mensaje: Modal.mensajeSinDatos(mensaje: SIN_PROVINCIAS),
            icono: Modal.iconoAdvertencia(),
          );
        }
      },
    );
  }

  Widget _buildInformacionSubirDatos() {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controlador.cantidadCaracterizacion > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controlador.cantidadCaracterizacion} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'No existen registros para ser almacenados en el Sistema GUIA');
          }
        },
      ),
    );
  }

  Widget _buildBotonSubirDatos() {
    return CuerpoFormularioSincronizacion.botonSincronizar(
      () async {
        await controlador.subirDatos(
          titulo: SINCRONIZANDO_UP,
          mensaje: _buildMensajeModalSincronizados(),
          icono: _buildIconoModalSincronizados(),
        );
      },
    );
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<CaracterizacionFrMfSvController>(
      builder: (_) {
        if (_.validandoBajada.value) return Modal.cargando();
        if (_.estadoBajada == 'error') {
          return Modal.iconoError();
        } else if (_.estadoBajada == 'advertencia') {
          return Modal.iconoAdvertencia();
        } else {
          return Modal.iconoValido();
        }
      },
    );
  }

  Widget _buildMensajeModalSincronizados() {
    return Obx(
      () {
        return Modal.mensajeSincronizacion(
            mensaje: controlador.mensajeBajarDatos.value, fontSize: 12);
      },
    );
  }
}

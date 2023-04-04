import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/modules/trampeo_mosca_sv/controllers/trampeo_mf_sv_controller.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_sincronizacion.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class SincronizacionTrampeoMfSv extends StatelessWidget {
  SincronizacionTrampeoMfSv({Key? key}) : super(key: key);

  final controlador = Get.find<TrampeoMfSvController>();

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return CuerpoFormularioSincronizacion(
      titulo: 'Registro de Trampeo MF',
      widgetsBajarDatos: ContenidoTabSincronizacion(
        widgets: [
          _buildComboProvincia1(context),
          const Espaciador(alto: 20),
          _buildComboProvincia2(context),
          _informacionBajarDatos(),
          const Espaciador(alto: 40),
          _botonBajarDatos(context),
        ],
      ),
      widgetsSubirDatos: ContenidoTabSincronizacion(
        widgets: [
          _informacionSubirDatos(),
          const Espaciador(alto: 40),
          _buildBotonSubirDatos(),
        ],
      ),
    );
  }

  Widget _buildComboProvincia1(context) {
    return GetBuilder<TrampeoMfSvController>(builder: (_) {
      return Combo(
        items: _.listaProvinciasDropDown.map((e) {
          return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
        }).toList(),
        onChanged: (valor) {
          _.obtenerProvincia2();
          _.setProvincia = valor;
        },
        label: 'Provincia 1',
      );
    });
  }

  Widget _buildComboProvincia2(context) {
    return GetBuilder<TrampeoMfSvController>(builder: (_) {
      return Combo(
        items: _.provincia2.map((e) {
          return DropdownMenuItem(value: e.idGuia, child: Text(e.nombre!));
        }).toList(),
        onChanged: (valor) {
          _.setProvincia2 = valor;
        },
        label: 'Provincia 2',
      );
    });
  }

  Widget _botonBajarDatos(context) {
    return CuerpoFormularioSincronizacion.botonSincronizar(() async {
      if (controlador.provinciaBajada1 != 0) {
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
    });
  }

  Widget _informacionBajarDatos() {
    return CuerpoFormularioSincronizacion.informacionBajarDatos();
  }

  Widget _informacionSubirDatos() {
    return CuerpoFormularioSincronizacion.informacionSubirDatos(
      Obx(
        () {
          if (controlador.cantidadTrampeo > 0) {
            return CuerpoFormularioSincronizacion.textoMensajes(
                'Existen ${controlador.cantidadTrampeo} Registros para ser almacenados en el Sistema GUIA');
          } else {
            return CuerpoFormularioSincronizacion.textoMensajes(SIN_REGISTROS);
          }
        },
      ),
    );
  }

  Widget _buildBotonSubirDatos() {
    return CuerpoFormularioSincronizacion.botonSincronizar(() async {
      await controlador.subirDatos(
        titulo: SINCRONIZANDO_UP,
        mensaje: _buildMensajeModalSincronizados(),
        icono: _buildIconoModalSincronizados(),
      );
    });
  }

  Widget _buildIconoModalSincronizados() {
    return GetX<TrampeoMfSvController>(
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
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controlador.mensajeBajarDatos.value, fontSize: 12);
    });
  }
}

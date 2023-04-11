import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/registroInformacion/controllers/registroInformacionController.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DatosRegistroPaso3 extends StatefulWidget {
  final controlador = Get.find<RegistroInformacionController>();
  DatosRegistroPaso3({Key? key}) : super(key: key);

  @override
  State<DatosRegistroPaso3> createState() => _DatosRegistroState();
}

class _DatosRegistroState extends State<DatosRegistroPaso3>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Medidas().init(context);
    return GetBuilder<RegistroInformacionController>(
        builder: (_) => CuerpoFormularioIngreso(
            titulo: "Formulario Ingreso",
            widgets: [
              NombreSeccion(
                etiqueta: 'Datos de la Entidad',
              ),
              _buildCertificadoZoosanitario(),
              _buildNombreRepresentanteLegal(),
              _buildFrontera(),
              _buildPaisProcedencia(),
              _buildNumeroPermiso(),
              _buildRazonSocial(),
              buildBotonRegresar()
            ],
            botonFormulario: _buildBotonContinuar()));
  }

  Widget buildBotonRegresar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      height: 28,
      width: 28,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: CircleBorder(),
          backgroundColor: Colors.white,
        ),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        onPressed: () =>
            Navigator.pushReplacementNamed(context, 'datosEntidad'),
      ),
    );
  }

  Widget _buildCertificadoZoosanitario() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.certificadoZoosanitariaTextController,
      label: 'Certificado Zoosanitario',
      onChanged: (valor) => Get.find<RegistroInformacionController>()
          .setCertificadoZoosanitaria = valor,
    );
  }

  Widget _buildNombreRepresentanteLegal() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.nombreRepresentanteLegTextController,
      label: 'Nombre del Representante Legal',
      onChanged: (valor) => Get.find<RegistroInformacionController>()
          .setNombreRepresentanteLeg = valor,
    );
  }

  Widget _buildFrontera() {
    final controlador = Get.find<RegistroInformacionController>();
    return Row(
      children: [
        Obx(() {
          return Checkbox(
            value: controlador.frontera.value,
            onChanged: (bool? valor) {
              controlador.setFrontera = valor!;
              controlador.frontera.value = valor;
            },
          );
        }),
        Text('Frontera', style: _textoStyle()),
      ],
    );
  }

  Widget _buildPaisProcedencia() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      enable: controlador.frontera.value,
      controller: controlador.paisProcedenciaTextController,
      label: 'País de procedencia de la importación',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setPaisProcedencia = valor,
    );
  }

  Widget _buildNumeroPermiso() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      enable: controlador.frontera.value,
      controller: controlador.numeroPermisoFitosanitarioTextController,
      label: 'Número de permiso Fito sanitario',
      onChanged: (valor) => Get.find<RegistroInformacionController>()
          .setNumeroPermisoFito = valor,
    );
  }

  Widget _buildRazonSocial() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      enable: controlador.frontera.value,
      controller: controlador.razonSocialExportadorTextController,
      label: 'Razon Social del Exportador',
      onChanged: (valor) => Get.find<RegistroInformacionController>()
          .setRazonSocialExportador = valor,
    );
  }

  BotonPlano _buildBotonContinuar() {
    final controlador = Get.find<RegistroInformacionController>();
    return BotonPlano(
      texto: 'Continuar',
      color: Color(0XFF1ABC9C),
      funcion: () async {
        bool valido = controlador.validarFormulario();
        if (valido) {
          Navigator.pushReplacementNamed(context, 'datosMuestra');
        } else
          snackBarExterno(
            mensaje: SNACK_OBLIGATORIOS,
            context: Get.context!,
            elevation: 6,
            snackBarBehavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: await tieneFaceID() ? 20 : 50, left: 10, right: 10),
          );
      },
      icono: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
    );
  }

  _textoStyle() {
    return TextStyle(color: Color(0xFF75808f));
  }
}

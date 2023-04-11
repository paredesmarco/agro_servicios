import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_descripcion.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
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
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:agro_servicios/app/utils/catalogos/catalalogos_registro_info.dart';

import '../../core/widgets/campo_texto.dart';

class DatosRegistroPaso1 extends StatefulWidget {
  final controlador = Get.find<RegistroInformacionController>();
  DatosRegistroPaso1({Key? key}) : super(key: key);

  @override
  State<DatosRegistroPaso1> createState() => _DatosRegistroState();
}

class _DatosRegistroState extends State<DatosRegistroPaso1> {
  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return GetBuilder<RegistroInformacionController>(
      builder: (_) => CuerpoFormularioIngreso(
          titulo: "Formulario Ingreso",
          widgets: [
            NombreSeccion(
              etiqueta: 'Datos Generales',
            ),
            CampoDescripcion(
              etiqueta: 'Fecha de toma de la muestra',
              valor: fechaFormateada('yyyy-MM-dd', DateTime.now()),
            ),
            NombreSeccion(
              etiqueta: 'Datos del Registro',
            ),
            _buildPrograma(),
            _buildCodigoMuestra(),
            _buildNombreMuestra(),
          ],
          botonFormulario: _buildBotonContinuar()),
    );
  }

  Widget _buildPrograma() {
    final controlador = Get.find<RegistroInformacionController>();
    return GetBuilder<RegistroInformacionController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          selectedItem: controlador.registro.programa,
          lista: CatalogoRegistroInfo().getProgramaLista(),
          label: 'Programa',
          errorText: _.errorPrograma,
          onChange: (valor) {
            _.setPrograma = valor;
          },
        );
      },
    );
  }

  Widget _buildCodigoMuestra() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.codigoMuestraCamTextController,
      label: 'Código de la muestra de campo',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setCodigoMuestraCam = valor,
    );
  }

  Widget _buildNombreMuestra() {
    return GetBuilder<RegistroInformacionController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          selectedItem: _.registro.nombreMuestra,
          lista: CatalogoRegistroInfo().getProductoLista(),
          label: 'Nombre de la muestra (producto agrícola o pecuario)',
          errorText: _.errorProducto,
          onChange: (valor) {
            _.setNombreMuestra = valor;
          },
        );
      },
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
          Navigator.pushReplacementNamed(context, 'datosEntidad');
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
}

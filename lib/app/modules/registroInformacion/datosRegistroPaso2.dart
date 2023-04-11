import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/core/widgets/boton_plano.dart';
import 'package:agro_servicios/app/core/widgets/campo_texto.dart';
import 'package:agro_servicios/app/core/widgets/combo.dart';
import 'package:agro_servicios/app/core/widgets/combo_busqueda.dart';
import 'package:agro_servicios/app/core/widgets/cuerpo_formulario_ingreso.dart';
import 'package:agro_servicios/app/core/widgets/nombre_seccion.dart';
import 'package:agro_servicios/app/modules/registroInformacion/controllers/registroInformacionController.dart';
import 'package:agro_servicios/app/utils/catalogos/catalalogos_registro_info.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/utils/snack_bar.dart';
import 'package:agro_servicios/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DatosRegistroPaso2 extends StatefulWidget {
  final controlador = Get.find<RegistroInformacionController>();
  DatosRegistroPaso2({Key? key}) : super(key: key);

  @override
  State<DatosRegistroPaso2> createState() => _DatosRegistroState();
}

class _DatosRegistroState extends State<DatosRegistroPaso2>
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
              _buildProvinciaCombo(),
              _Canton(),
              _buildParroquia(),
              _buildOrigenMuestra(),
              _buildNombreSitio(),
              _buildCentroFaenamiento(),
              buildBotonRegresar(),
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
            Navigator.pushReplacementNamed(context, 'datosRegistro'),
      ),
    );
  }

  Widget _buildProvinciaCombo() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: GetBuilder<RegistroInformacionController>(
            id: 'provincia',
            builder: (_) => Combo(
                  key: UniqueKey(),
                  label: 'Provincia',
                  items: CatalogoRegistroInfo()
                      .getProvinciaLista()
                      .map((e) => DropdownMenuItem(
                          child: Text(e.nombre!), value: e.idGuia))
                      .toList(),
                  onChanged: (valor) {},
                )));
  }

  Widget _buildParroquia() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder< /*rampeoMfSvLugarController*/
          RegistroInformacionController>(
        id: 'parroquia',
        builder: (_) => Combo(
          key: UniqueKey(),
          items: /*_.parroquia*/ CatalogoRegistroInfo()
              .getParroquiaLista()
              .map((e) => DropdownMenuItem(
                  child: Text(e?.nombre ?? ''), value: e?.idGuia))
              .toList(),
          onChanged: (valor) {},
          label: 'Parroquia',
        ),
      ),
    );
  }

  Widget _buildOrigenMuestra() {
    return GetBuilder<RegistroInformacionController>(
      id: 'idValidacion',
      builder: (_) {
        return ComboBusqueda(
          selectedItem: _.registro.origenMuestra,
          lista: CatalogoRegistroInfo().getOrigenMuestraLista(),
          label: 'Origen de la muestra',
          errorText: _.errorOrigenMuestra,
          onChange: (valor) {
            _.setOrigenMuestra = valor;
          },
        );
      },
    );
  }

  Widget _buildNombreSitio() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.nombreSitioTextController,
      label: 'Nombre del Sitio',
      onChanged: (valor) =>
          Get.find<RegistroInformacionController>().setNombreSitio = valor,
    );
  }

  Widget _buildCentroFaenamiento() {
    final controlador = Get.find<RegistroInformacionController>();
    return CampoTexto(
      maxLength: 30,
      controller: controlador.codigoCentroFaenamientoTextController,
      label: 'Codigo del Centro de Faenamiento',
      onChanged: (valor) => Get.find<RegistroInformacionController>()
          .setCodigoCentroFaenamiento = valor,
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
          Navigator.pushReplacementNamed(context, 'datosFronteraEntidad');
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

class _Canton extends StatelessWidget {
  const _Canton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GetBuilder< /*TrampeoMfSvLugarController*/
          RegistroInformacionController>(
        id: 'canton',
        builder: (_) {
          return Combo(
            key: UniqueKey(),
            items: /*_.cantones*/
                CatalogoRegistroInfo().getCantonLista().map((e) {
              return DropdownMenuItem(
                  child: Text(e?.nombre ?? ''), value: e?.idGuia);
            }).toList(),
            onChanged: (valor) {},
            label: 'Cantón',
          );
        },
      ),
    );
  }
}

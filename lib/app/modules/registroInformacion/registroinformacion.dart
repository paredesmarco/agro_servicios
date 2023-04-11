import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:agro_servicios/app/modules/registroInformacion/datosRegistroPaso1.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/utils/medidas.dart';

class RegistrarInformacion extends StatelessWidget {
  RegistrarInformacion({Key? key}) : super(key: key);
  //final controlador = Get.find<TrampeoMfSvController>();
  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          //floatingActionButton: _buildFab(),
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () => {}, icon: Icon(Icons.search))
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Registro Información"),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: 5),
              labelPadding: EdgeInsets.only(bottom: 5),
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: FaIcon(FontAwesomeIcons.clipboardList)),
                Tab(icon: FaIcon(FontAwesomeIcons.mapMarked)),
                Tab(icon: FaIcon(FontAwesomeIcons.flask)),
                Tab(icon: FaIcon(FontAwesomeIcons.edit)),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF09c273), Color(0xFFF05b386)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Espaciador(
                    alto: MediaQuery.of(context).padding.top,
                  ),
                  Container(height: 107),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: TabBarView(
                        //controller: controlador.tabController,
                        physics: BouncingScrollPhysics(),
                        children: [
                          DatosRegistroPaso1(),
                          Center(child: Text("Datos de la Entidad")),
                          Center(child: Text("Datos de la muestra")),
                          Center(child: Text("Acciones tomadas"))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

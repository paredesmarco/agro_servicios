import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:agro_servicios/app/common/colores.dart';
import 'package:agro_servicios/app/utils/dependecy_injections.dart';
import 'package:agro_servicios/app/modules/inicial/inicial_biding.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_caracteristicas.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_orden_laboratorio.dart';
import 'package:agro_servicios/app/bloc/vigilancia_sv/bloc_ubicacion.dart';
import 'package:agro_servicios/app/routes/app_pages.dart';
import 'package:agro_servicios/app/bloc/bloc_aplicaciones.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';
import 'package:agro_servicios/app/bloc/trampeo_sv/bloc_trampeo.dart';

void main() {
  DependecyInjections.init();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AplicacionesBloc()),
        ChangeNotifierProvider(create: (_) => LoginBloc()),
        ChangeNotifierProvider(create: (context) => TrampeoBloc()),
        ChangeNotifierProvider(create: (_) => CaracteristicasBloc()),
        ChangeNotifierProvider(create: (_) => OrdenLaboratorioSvBloc()),
        ChangeNotifierProvider(create: (_) => UbicacionBloc())
      ],
      child: GetMaterialApp(
        title: 'AGRO Servicios',
        initialRoute: Rutas.INITIAL,
        getPages: AppPages.pages,
        initialBinding: InicialBinding(),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'EC'),
        ],
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // ignore: deprecated_member_use
          accentColor: Colores.accentColor,
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}

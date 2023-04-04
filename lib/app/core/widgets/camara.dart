import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Camara extends StatefulWidget {
  const Camara({super.key});
  @override
  State<StatefulWidget> createState() => _CamaraState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR, PERMISOS }

class _CamaraState extends State<Camara> with WidgetsBindingObserver {
  WidgetState _widgetState = WidgetState.NONE;
  late List<CameraDescription> _cameras;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    initCam();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_cameraController != null) {
        onNewCameraSelected(_cameraController!.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    switch (_widgetState) {
      case WidgetState.NONE:
      case WidgetState.LOADING:
        return buildScaffold(
            context,
            const Center(
                child: CircularProgressIndicator(
              color: Color(0XFF1ABC9C),
            )));
      case WidgetState.LOADED:
        final double altura = orientacion.index == 0
            ? MediaQuery.of(context).size.height * 0.7
            : MediaQuery.of(context).size.height * 1;
        final double ancho = orientacion.index == 0
            ? double.infinity
            : MediaQuery.of(context).size.width * 0.75;
        return buildScaffold(
            context,
            SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                        height: altura,
                        width: ancho,
                        child: CameraPreview(_cameraController!)),
                  ),
                  buildBotonRegresar()
                ],
              ),
            ));
      case WidgetState.ERROR:
        return buildScaffold(
          context,
          SafeArea(
            child: Stack(
              children: [
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "¡Ooops! Error al cargar la cámara 😩. Reinicia la apliación.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
                buildBotonRegresar(),
              ],
            ),
          ),
        );
      case WidgetState.PERMISOS:
        return buildScaffold(
          context,
          SafeArea(
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Otorga los permisos a AGRO Servicios para acceder a la cámara del dispositivo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                buildBotonRegresar()
              ],
            ),
          ),
        );
    }
  }

  Widget buildScaffold(BuildContext context, Widget body) {
    Medidas().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: body,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () async {
              try {
                final imagen = await _cameraController!.takePicture();

                Get.back(result: imagen);
              } catch (e) {
                debugPrint('$e');
              }
            },
            child: const Icon(
              Icons.camera,
              color: Colors.white,
              size: 55,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: orientacion.index == 0
          ? FloatingActionButtonLocation.centerFloat
          : CustomFabLoc(),
    );
  }

  Widget buildBotonRegresar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      height: 28,
      width: 28,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
        ),
        child: const Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  Future<void> initCam() async {
    try {
      _cameraController?.dispose();

      _widgetState = WidgetState.LOADING;
      if (mounted) setState(() {});

      _cameras = await availableCameras();

      _cameraController = CameraController(
        _cameras[0],
        ResolutionPreset.veryHigh,
        enableAudio: false,
        // imageFormatGroup: ImageFormatGroup.bgra8888,
      );

      // Si el controlador es actualizado se actualiza la vista.
      _cameraController!.addListener(() {
        if (mounted) {
          setState(() {
            _widgetState = WidgetState.LOADED;
          });
        }
        if (_cameraController!.value.hasError) {
          debugPrint(
              'Error camara: ${_cameraController!.value.errorDescription}');
        }
      });

      await _cameraController!.initialize();
      try {
        await _cameraController!.setFlashMode(FlashMode.off);
      } catch (e) {
        debugPrint('error flash>> $e');
      }
    } catch (e) {
      debugPrint('error camara>> $e');
      _mensajeError(
          mensaje: 'Asegurate de otorgar acceso a la cámara del dispositivo');
      setState(() {
        _widgetState = WidgetState.PERMISOS;
      });
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _cameraController = cameraController;

    // Si el controlador es actualizado se actualiza la vista.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        debugPrint('Error camara: ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await cameraController.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  _mensajeError(
      {required String mensaje,
      String titulo = 'No se puede tomar una fotografía'}) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  // Navigator.of(context, rootNavigator: true).pop();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width * .9,
      scaffoldGeometry.scaffoldSize.height * 0.55 - kToolbarHeight,
    );
  }
}

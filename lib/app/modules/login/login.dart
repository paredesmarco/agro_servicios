import 'dart:io';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:get/get.dart';

import 'package:agro_servicios/app/core/widgets/boton.dart';
import 'package:agro_servicios/app/core/widgets/widgets.dart';
import 'package:agro_servicios/app/core/widgets/modal.dart';
import 'package:agro_servicios/app/modules/login/login_controlador.dart';
import 'package:agro_servicios/app/core/widgets/boton_autenticacion.dart';
import 'package:agro_servicios/app/core/widgets/switch_conexion.dart';
import 'package:agro_servicios/app/utils/medidas.dart';
import 'package:agro_servicios/app/bloc/bloc_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LocalAuthentication auth = LocalAuthentication();
  final controlador = Get.find<LoginController>();

  //List<BiometricType> _availableBiometrics;
  String authorized = 'Not Authorized';

  bool _biometricoDisponible = false;
  final bool _isAuthenticating = false;
  double _alturaBNV = 60;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode nodo1 = FocusNode();
  FocusNode nodo2 = FocusNode();

  final TextEditingController _usuarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comprobarBiometricos();
    _tipoBiometricoDisponibles();
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Medidas().init(context);
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Selector<LoginBloc, Tuple2<UsuarioModelo?, double>>(
        selector: (_, provider) =>
            Tuple2(provider.listaUsuario, provider.margenBar),
        builder: (_, data, w) {
          if (data.item1 != null) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _alturaBNV,
              margin: EdgeInsets.symmetric(
                // vertical: altoPantalla * 0.02,
                horizontal: data.item2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(33),
                ),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0XFFC2C2C2).withOpacity(0.6),
                      offset: const Offset(0, 5),
                      spreadRadius: 1.5,
                      blurRadius: 10.0),
                ],
              ),
              child: Center(child: _crearBotonesTipoLogin()),
            );
          }

          return Container(
            height: 10.0,
          );
        },
      ),
      // backgroundColor: Colors.transparent,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            //physics: BouncingScrollPhysics(),
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _crearEncabezado(),
                  SizedBox(
                    height: (altoPantalla <= 592.0)
                        ? altoPantalla * 0.040
                        : altoPantalla * 0.075,
                  ),
                  Center(
                    child: _formulario(),
                  ),
                  if (orientacion.index == 1) const Espaciador(alto: 20)
                ]),
          ),
        ),
      ),
    );
  }

  Widget _crearEncabezado() {
    return Selector<LoginBloc, Tuple2<String, String>>(
      selector: (_, provider) =>
          Tuple2(provider.mensajeBienvenido, provider.mensajeDescripcion),
      builder: (_, data, w) {
        return Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
                width: orientacion.index == 0
                    ? getProporcionAlturaPantalla(100.0)
                    : getProporcionAlturaPantalla(150.0),
                child: Image.asset('img/logo.png')),
            SizedBox(
              height: getProporcionAlturaPantalla(20.0),
            ),
            Text(
              data.item1,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800),
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              width: getProporcionAnchoPantalla(340),
              child: Center(
                child: Text(
                  data.item2,
                  style: const TextStyle(
                    color: Color(0XFF999999),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _formulario() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Selector<LoginBloc, UsuarioModelo?>(
              selector: (_, provider) => provider.listaUsuario,
              builder: (_, data, w) {
                if (data != null) {
                  return Column(
                    children: [
                      SwitchConexion(
                        limpiarUsuario: _limpiarUsuario,
                      ),
                      SizedBox(
                        height: getProporcionAlturaPantalla(15.0),
                      ),
                    ],
                  );
                }
                return SizedBox(
                  height: getProporcionAlturaPantalla(15.0),
                );
              },
            ),
            Selector<LoginBloc, String>(
              selector: (_, provider) => provider.mensajeTipoLogin,
              builder: (_, data, w) {
                return Text(
                  data,
                  style: const TextStyle(fontSize: 16.0),
                );
              },
            ),
            SizedBox(
              height: getProporcionAlturaPantalla(15.0),
            ),
            _crearTextoUsuario(),
            SizedBox(
              height: getProporcionAlturaPantalla(25.0),
            ),
            _crearTextoClave(),
            SizedBox(
              height: getProporcionAlturaPantalla(30.0),
            ),
            Selector<LoginBloc, UsuarioModelo?>(
              selector: (_, provider) => provider.listaUsuario,
              builder: (_, data, w) {
                if (data != null) return _crearBotonLogin();
                return SizedBox(
                    height: altoPantalla * 0.20,
                    child: Center(child: _crearBotonLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearTextoUsuario() {
    final loginProvider = Provider.of<LoginBloc>(context, listen: false);
    return Selector<LoginBloc, bool>(
      selector: (_, provider) => provider.campoActivo,
      builder: (_, data, w) {
        return TextFormField(
          controller: _usuarioController,
          enabled: data,
          cursorColor: Colors.green,
          focusNode: nodo1,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term) {
            nodo1.unfocus();
            FocusScope.of(context).requestFocus(nodo2);
          },
          onSaved: (String? valor) {
            loginProvider.usuario = valor;
            controlador.setUsuario = valor;
          },
          validator: (String? valor) {
            if (loginProvider.tipoIngreso == 'usuario') {
              if (valor == null || valor == '') {
                return 'El campo usuario es requerido';
              }
              return null;
            }
            return null;
          },
          decoration: InputDecoration(
            //counterText: "",
            suffixStyle: const TextStyle(fontWeight: FontWeight.bold),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 21.0),
              child: Icon(
                Icons.person_outline,
                size: 20.0,
              ),
            ),
            labelText: 'Usuario',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
          ),
        );
      },
    );
  }

  Widget _crearTextoClave() {
    final loginProvider = Provider.of<LoginBloc>(context, listen: false);
    return Selector<LoginBloc, Tuple4<bool, String, Icon, String>>(
      selector: (_, provider) => Tuple4(
          provider.esVisible,
          provider.mensajeCampoClave,
          provider.iconoVisible,
          provider.mensajeCampoClave),
      builder: (_, data, w) {
        return TextFormField(
          cursorColor: Colors.green,
          obscureText: data.item1,
          focusNode: nodo2,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term) async {
            _enviarDatos();
          },
          onSaved: (String? valor) {
            loginProvider.clave = valor;
            controlador.setClave = valor;
          },
          validator: (String? valor) {
            if (valor == null || valor == '') {
              return 'El campo ${data.item2} es requerido';
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: data.item3,
                onPressed: () => loginProvider.setVisible = data.item1,
              ),
            ),
            labelText: data.item2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
          ),
        );
      },
    );
  }

  Widget _crearBotonLogin() {
    return Selector<LoginBloc, String>(
      selector: (_, provider) => provider.mensajeBotonLogin,
      builder: (_, data, w) {
        return SizedBox(
          width: getProporcionAnchoPantalla(248),
          // height: getProporcionAlturaPantalla(43),
          height: 35,
          // height: MediaQuery.of(context).size.height * 0.043,
          child: Boton(
              texto: data,
              color: const Color(0xff09c273),
              funcion: _enviarDatos),
        );
      },
    );
  }

  Widget _crearBotonesTipoLogin() {
    final loginProvider = Provider.of<LoginBloc>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Selector<LoginBloc, bool>(
            selector: (_, providers) => providers.getOnline,
            builder: (_, data, w) {
              if (data) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        BotonTipoAutenticacion(
                          icono: const Icon(Icons.person_outline, size: 30.0),
                          funcion: () {
                            controlador.setTipoIngreso = 'usuario';
                            loginProvider.setTipoIngreso = 'usuario';
                            loginProvider.setMensajeTipoLogin =
                                'Usuario y Contraseña';
                            loginProvider.setMensajeCampoClave = 'Contraseña';
                            loginProvider.setCampoActivo = true;
                            _formKey.currentState?.reset();
                          },
                          ancho: 50,
                          alto: 50,
                          color: const Color(0xff09c273),
                          sizeIcon: 25,
                        ),
                        SizedBox(
                          width: getProporcionAnchoPantalla(40.0),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
          if (_biometricoDisponible)
            BotonTipoAutenticacion(
              icono: const Icon(Icons.fingerprint, size: 30.0),
              funcion: () {
                _isAuthenticating
                    ? _cancelAuthentication()
                    : controlador.validarBiometricos(
                        titulo: 'Inicio de sesión',
                        mensaje: _mensajeModal(),
                        icono: _iconoModal());
              },
              color: const Color(0xff09c273),
              alto: 50,
              ancho: 50,
              sizeIcon: 30,
            ),
          if (loginProvider.getOnline)
            SizedBox(
              width: getProporcionAnchoPantalla(40.0),
            ),
          Row(
            children: [
              if (!loginProvider.getOnline && _biometricoDisponible)
                SizedBox(
                  width: getProporcionAnchoPantalla(40.0),
                ),
              BotonTipoAutenticacion(
                icono: const Icon(Icons.more_horiz, size: 30.0),
                funcion: () {
                  _formKey.currentState?.reset();
                  _usuarioController.text = '';
                  loginProvider.setMensajeTipoLogin = 'PIN';
                  loginProvider.setMensajeCampoClave = 'PIN';
                  loginProvider.setCampoActivo = false;
                  loginProvider.setTipoIngreso = 'pin';
                  controlador.setTipoIngreso = 'pin';
                },
                color: const Color(0xff09c273),
                alto: 50,
                ancho: 50,
                sizeIcon: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _limpiarUsuario() {
    _formKey.currentState?.reset();
    _usuarioController.text = '';
  }

  void _enviarDatos() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (controlador.online) {
      controlador.validarUsuarioOnline(
        titulo: 'Verificando Datos',
        icono: _iconoModal(),
        mensaje: _mensajeModal(),
      );
    } else {
      controlador.validarUsuarioPin(
        titulo: 'Verificando Datos',
        icono: _iconoModal(),
        mensaje: _mensajeModal(),
      );
    }
  }

  Widget _iconoModal() {
    return Obx(() {
      if (controlador.validandoLogin.value) return Modal.cargando();
      if (controlador.estadoLogin.value == 'exito') {
        return Modal.iconoValido();
      } else {
        return Modal.iconoError();
      }
    });
  }

  Widget _mensajeModal() {
    return Obx(() {
      return Modal.mensajeSincronizacion(
          mensaje: controlador.mensajeLogin.value);
    });
  }

  Future<void> _comprobarBiometricos() async {
    bool biometricoDisponible = false;
    try {
      biometricoDisponible = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint('$e');
    }
    if (!mounted) return;

    setState(() {
      _biometricoDisponible = biometricoDisponible;
    });
  }

  Future<void> _tipoBiometricoDisponibles() async {
    List<BiometricType> a = await auth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (a.contains(BiometricType.face)) {
        _alturaBNV = 75;
      } else if (a.contains(BiometricType.fingerprint)) {
        _alturaBNV = 60;
        // Touch ID.
      }
    } else {
      _alturaBNV = 60;
    }
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
}

class FormularioTrampaNuevaModelo {
  String? propiedad = '';
  String? condicionTrampa = '--';
  String? especie = '--';
  String? procedencia = '--';
  String? condicionCultivo = '--';
  String? etapaCultivo = '--';
  String exposicion = '';
  String? cambioFeromona = '';
  String? cambioPapel = '';
  String? cambioAceite = '';
  String? cambioTrampa = '';
  String? numeroEspecimen = '';
  String? diagnosticoVisual = '--';
  String? etapaPlaga = '--';
  String? observaciones = '';
  String? muestraLaboratorio = '';

  static final FormularioTrampaNuevaModelo _instancia =
      FormularioTrampaNuevaModelo._constructor();

  FormularioTrampaNuevaModelo._constructor();

  factory FormularioTrampaNuevaModelo() {
    return _instancia;
  }

  encerarCampos() {
    propiedad = '';
    condicionTrampa = '--';
    especie = '--';
    procedencia = '--';
    condicionCultivo = '--';
    etapaCultivo = '--';
    exposicion = '';
    cambioFeromona = '';
    cambioPapel = '';
    cambioAceite = '';
    cambioTrampa = '';
    numeroEspecimen = '';
    diagnosticoVisual = '--';
    etapaPlaga = '--';
    observaciones = '';
    muestraLaboratorio = '';
  }
}

class TrampasCompletadasModelo {
  int? index;
  int? idTrampa;
  String? codigoTrampa;
  String? muestraLaboratorio;
  int? secuencialTrampa;

  TrampasCompletadasModelo(
      {this.index,
      this.idTrampa,
      this.codigoTrampa,
      this.muestraLaboratorio,
      this.secuencialTrampa});

  @override
  String toString() {
    return ''' TrampasCompletadasModelo{
      index: $index,
      idTrampa: $idTrampa,
      codigoTrampa: $codigoTrampa,
      muestraLaboratorio: $muestraLaboratorio,
      secuencialTrampa: $secuencialTrampa,
    }''';
  }
}

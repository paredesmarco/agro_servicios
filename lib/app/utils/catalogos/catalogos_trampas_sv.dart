import 'package:flutter/material.dart';

class CatalogosTrampasSv {
  final _condicionTrampa = [
    '--',
    'Excelente',
    'Buena',
    'Mala',
    'Pérdida',
  ];

  final _especiesVegetal = [
    'NO APLICA',
    'ACHOTILLO',
    'AGUACATE',
    'AJÍ',
    'ALMEDRO',
    'ALMIDÓN DE ARROZ',
    'ARAZÁ',
    'ARROZ',
    'ARVEJA',
    'AVENA',
    'BABACO',
    'BADEA',
    'BALANCEADOS',
    'BANANO',
    'BOSQUE ',
    'BOSQUE SECUNDARIO',
    'CACAO',
    'CAFÉ',
    'CAIMITO',
    'CAÑA',
    'CAPULÍ',
    'CARAMBOLA',
    'CAIMITO, CAUJE, ABIO',
    'CEBADA',
    'CEREZA',
    'CEREZA CHINA',
    'CHIGUALCÁN',
    'CHIRIMOYA',
    'CHIRIMOYUELA',
    'CIRUELA',
    'CIRUELO  (OVO)',
    'CIRUELO CHINO',
    'CLAUDIA',
    'COCO',
    'COMESTIBLE DE PALMA AFRICANA',
    'DURAZNO',
    'FEIJOA',
    'FRÉJOL',
    'FRAMBUESA',
    'FRUTALES',
    'FRUTERÍA',
    'GRANADA',
    'GRANADILLA',
    'GRANOS ALMACENADOS',
    'GROSELLA',
    'GUABA',
    'GUABA MACHETÓN',
    'GUABA SERRANA',
    'GUANÁBANA',
    'GUAYABA',
    'GUAYTAMBO',
    'HARINA',
    'HIGO',
    'LIMA',
    'LIMÓN',
    'LUCMA O LÚCUMA',
    'MAÍZ',
    'MAMEY COLORADO',
    'MANDARINA',
    'MANDARINA CLEOPATRA',
    'MANGO',
    'MANZANA',
    'MAQUEÑO',
    'MARACUYÁ',
    'MELÓN',
    'MERCADOS',
    'MIRTO',
    'MORA',
    'NARANJA',
    'NARANJA AGRIA',
    'NARANJA DULCE',
    'NARANJA TRIFOLIA',
    'NARANJILLA',
    'NÍSPERO SIERRA',
    'NÍSPERO TROPICAL',
    'NOGAL, TOCTE',
    'ORITO',
    'PALMA ACEITERA',
    'PAPAYA',
    'PASTO ',
    'PECHICHE',
    'PEPINILLO',
    'PEPINO DULCE',
    'PERA',
    'PERA DE AGUA  ',
    'PIMIENTO',
    'PITAHAYA',
    'PLÁTANO HARTÓN',
    'PLÁTANO BARRAGANETE',
    'PLÁTANO DOMINICO',
    'PLÁTANO SEDA',
    'POMARROSA',
    'POMELO',
    'POSTE',
    'QUINUA',
    'REINA CLAUDIA',
    'SANDÍA',
    'SHAWI',
    'SOYA',
    'SWINGLE',
    'TAMARINDO',
    'TANGELO',
    'TE',
    'TOCTE',
    'TOMATE DE ÁRBOL',
    'TORONJA',
    'TORTA DE MAÍZ',
    'TORTA DE SOYA',
    'TRIGO',
    'TUNA',
    'UVA',
    'UVA DE MONTE',
    'UVILLA',
    'YUCA',
    'ZAMBO',
    'ZAPALLO',
    'ZAPOTE',
    'ZAPOTILLO',
  ];

  final _procedencias = [
    '--',
    'Nacional',
    'Importado',
  ];

  final _condicionCultivo = [
    '--',
    'Campo abierto',
    'Invernadero',
    'Almacenamiento',
    'Otros',
  ];

  final _etapaCultivo = [
    '--',
    'Rastrojo/barbecho',
    'Macollamiento/brotación',
    'Desarrollo vegetativo',
    'Floración',
    'Fructificación',
    'Pre-cosecha',
    'Cosecha',
    'Post-cosecha',
  ];

  final _diagnosticoVisual = [
    '--',
    'No aplica',
    'Ahasverus advena',
    'Bactericera cockerelli',
    'Carpophilus hemipterus',
    'Carpophilusspp',
    'Cosmopolites sordidus',
    'Diaphorina citri',
    'Gnathocerus cornutus',
    'Lobesia botrana',
    'Oryzaephilus mercator',
    'Phthorimaea operculella',
    'Pterygium crenatum',
    'Ptinus tectus',
    'Rhynchophorus palmarum',
    'Rhyzopertha dominica',
    'Silvanus planatus',
    'Sitophilus granarius',
    'Sitophilus oryzae',
    'Sitophilus zeamais',
    'Spodoptera frugiperda',
    'Stenoma catenifer',
    'Symmetrischema tangolias',
    'Tecia solanivora',
    'Tribolium castaneum',
    'Trigonogenius globulus',
    'Trogoderma granarium',
  ];

  final _plagaMonitoreada = [
    '--',
    'No aplica',
    'Bactericera cockerelli',
    'Cosmopolites sordidus',
    'Diaphorina citri',
    'Lobesia botrana',
    'Phthorimaea operculella',
    'Rhynchophorus palmarum',
    'Spodoptera frugiperda',
    'Stenoma catenifer',
    'Symmetrischema tangolias',
    'Tecia solanivora',
    'Trogoderma granarium',
  ];

  final _productoOrdenLaboratorio = [
    '--',
    'Exportación',
    'Importación',
    'Otros'
  ];

  final _etapaDesarrollo = [
    '--',
    'Huevo',
    'Larva/ninfa',
    'Pupa',
    'Imago/Adulto',
    'No aplica'
  ];

  List<String> getEspecieVegetalString() {
    return _especiesVegetal;
  }

  List<String> getPrediagnosticoString() {
    return _diagnosticoVisual;
  }

  List<DropdownMenuItem<String>> getCondicionTrampa() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _condicionTrampa) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getEspecieVegetal() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _especiesVegetal) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getProcedencia() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _procedencias) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getCondicionCultivo() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _condicionCultivo) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getEtapaCultivo() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _etapaCultivo) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDiagnosticoVisual() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _diagnosticoVisual) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getPlagaMonitoreada() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _plagaMonitoreada) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getProductoOrdenLaboratorio() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _productoOrdenLaboratorio) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getEtapaDesarrollo() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in _etapaDesarrollo) {
      items.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    return items;
  }
}

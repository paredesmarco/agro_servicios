String codigoProvincia(String? provincia) {
  String codigo;
  switch (provincia) {
    case 'Azuay':
      codigo = '01';
      break;
    case 'Bolívar':
      codigo = '02';
      break;
    case 'Cañar':
      codigo = '03';
      break;
    case 'Carchi':
      codigo = '04';
      break;
    case 'Cotopaxi':
      codigo = '05';
      break;
    case 'Chimborazo':
      codigo = '06';
      break;
    case 'El Oro':
      codigo = '07';
      break;
    case 'Esmeraldas':
      codigo = '08';
      break;
    case 'Guayas':
      codigo = '09';
      break;
    case 'Imbabura':
      codigo = '10';
      break;
    case 'Loja':
      codigo = '11';
      break;
    case 'Los Ríos':
      codigo = '12';
      break;
    case 'Manabí':
      codigo = '13';
      break;
    case 'Morona Santiago':
      codigo = '14';
      break;
    case 'Napo':
      codigo = '15';
      break;
    case 'Pastaza':
      codigo = '16';
      break;
    case 'Pichincha':
      codigo = '17';
      break;
    case 'Tungurahua':
      codigo = '18';
      break;
    case 'Zamora Chinchipe':
      codigo = '19';
      break;
    case 'Galapagos':
      codigo = '20';
      break;
    case 'Sucumbíos':
      codigo = '21';
      break;
    case 'Orellana':
      codigo = '22';
      break;
    case 'Santo Domingo de los Tsáchilas':
      codigo = '23';
      break;
    case 'Santa Elena':
      codigo = '24';
      break;
    default:
      codigo = '00';
  }
  return codigo;
}

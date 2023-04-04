//
//Datos para la conexión con el webservice
//

// local: 10.0.2.2:80'  //pruebas: 181.112.155.173
const URL_SERVIDOR = "181.112.155.173";
const NOMBRE_PROYECTO = "agrodbPrueba";
const RUTA_MODULO = "aplicaciones/mvc/AplicacionMovilInternos";
const SCHEMA_VERSION = "1.3.4";
const AMBIENTE = "DE";
const BD_VERSION = 5;
const PUBLIC_KEY =
    "\$2y\$13\$syri71NLAc32kseeNrrnv.XaA/ysQ8sEs/tQkGE1cBCXmIJ6pBRp.";

/**
 * Rutas imagenes
 */

///Imagen para la visa predia de las fotos tomadas con la aplicación
const IMAGEN_PREVIA = 'img/previo-carga.png';
const ICONO_SA = 'img/icono_sa3.svg';
const ICONO_SV = 'img/icono_sv3.svg';

/**
 * Textos para Modal Bottom Sheet
 */

///Sincronizando datos del Sistema GUIA
const SINCRONIZANDO_DOWN = 'Sincronizando datos del Sistema GUIA';

///Sincronizando datos al Sistema GUIA
const SINCRONIZANDO_UP = 'Sincronizando datos al Sistema GUIA';

///Debe ingresar la información completa
const COMPLETAR_DATOS = 'Debe ingresar la información completa';

///Sin datos por sincronizar
const SIN_DATOS = 'Sin datos por sincronizar';

///Sin datos por sincronizar
const SIN_DATOS_FORM = 'Debe completar el formulario';

///Para realizar la sincronización debe seleccionar al menos una provincia
const SIN_PROVINCIAS =
    'Para realizar la sincronización debe seleccionar al menos una provincia';

///Almacenando datos del formulario
const ALMACENANDO = 'Almacenando datos del formulario';

///Sincronizando...
const DEFECTO_S = 'Sincronizando...';

///Almacenando...
const DEFECTO_A = 'Almacenando...';

///Almacenado exitosamente
const ALMACENADO_EXITO = 'Almacenado exitosamente';

/// Registros pendientes por sincronizar al Sistema GUIA en la sección "Subir Datos".    Para continuar, pimero debe sicronizar esos registros al Sistema GUIA
const REGISTROS_PENDIENTES =
    'Registros pendientes por sincronizar al Sistema GUIA en la sección "Subir Datos".    Para continuar, pimero debe sicronizar esos registros al Sistema GUIA';

///Registros pendientes de sincronización
const SINCRONIZACION_PENDIENTES = 'Registros pendientes de sincronización';

///No posee un contracto activo para determinar la provincia donde labora
const SIN_PROVINCIA_CONTRANTO =
    'No posee un contracto activo para determinar la provincia donde labora';
/**
 * Textos pantallas sincronización
 */

///No existen registros para ser almacenados en el Sistema GUIA
const SIN_REGISTROS =
    'No existen registros para ser almacenados en el Sistema GUIA';

/**
 * Textos validaciones formularios
 */

/// No existen registros para almacenar
const SIN_ALMACENAR = 'No existen registros para almacenar';

/// Este campo es requerido
const CAMPO_REQUERIDO = 'Este campo es requerido';

/// Revise los campos obligatorios
const SNACK_OBLIGATORIOS = 'Revise los campos obligatorios';

/// Debe ingresar un número válido
const CAMPO_NUMERICO_VALIDO = 'Debe ingresar un número válido';

/*
 * Textos para ordenes de laboratorio
 */

///Ingrese una Orden de laboratorio desde el botón "+"
const INGRESAR_ORDEN_LAB =
    'Ingrese una Orden de laboratorio desde el botón "+"';

///Orden de trabajo de laboratorio
const ORDEN_LABORATORIO = 'Orden de trabajo de laboratorio';

///Código de campo de la muestra
const CODIGO_MUESTRA = 'Código de campo de la muestra';

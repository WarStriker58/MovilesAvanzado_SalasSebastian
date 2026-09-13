# Sistema de Registro de Clientes

Programa desarrollado en **Swift** para el registro y consulta de clientes de una entidad. El sistema permite gestionar dos tipos de clientes: **Cliente Natural** y **Cliente Jurídico**.

El proyecto aplica conceptos de **Programación Orientada a Objetos (POO)**, principalmente **herencia, sobrescritura de métodos (`override`) y polimorfismo**. La clase `Cliente` contiene los datos comunes, mientras que `ClienteNatural` y `ClienteJuridico` incorporan la información específica de cada tipo.

## Funcionalidades principales

- Registro de clientes naturales y jurídicos.
- Validación de datos obligatorios.
- Validación del monto mínimo de apertura.
- Almacenamiento de múltiples clientes durante la ejecución.
- Visualización de los datos registrados.
- Generación de un reporte final de clientes.

## Requerimientos Funcionales

- **RF01.** El sistema deberá permitir seleccionar el tipo de cliente a registrar: Cliente Natural o Cliente Jurídico.
- **RF02.** El sistema deberá permitir registrar los datos comunes del cliente: código, dirección, fecha de registro, número de cuenta y monto mínimo de apertura.
- **RF03.** El sistema deberá permitir registrar los datos específicos de un Cliente Natural, incluyendo nombre completo y DNI.
- **RF04.** El sistema deberá permitir registrar los datos específicos de un Cliente Jurídico, incluyendo razón social, RUC y representante legal.
- **RF05.** El sistema deberá validar que los campos obligatorios no se encuentren vacíos.
- **RF06.** El sistema deberá validar que el monto mínimo de apertura sea un valor numérico mayor que cero.
- **RF07.** El sistema deberá almacenar los clientes registrados durante la ejecución del programa.
- **RF08.** El sistema deberá permitir registrar varios clientes de manera consecutiva.
- **RF09.** El sistema deberá mostrar los datos completos de cada cliente registrado.
- **RF10.** El sistema deberá mostrar la información correspondiente según el tipo de cliente registrado.
- **RF11.** El sistema deberá generar un reporte final con la información de todos los clientes registrados.

## Tecnologías

- **Lenguaje:** Swift
- **Tipo de aplicación:** Programa de consola
- **Paradigma:** Programación Orientada a Objetos (POO)

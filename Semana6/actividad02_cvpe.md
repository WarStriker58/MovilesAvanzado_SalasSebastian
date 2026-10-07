# Calculadora de Venta a Plazos de Electrodoméstico - Aplicación UIKit

## Descripción

La aplicación consiste en una calculadora de venta a plazos de electrodomésticos desarrollada en **Swift utilizando UIKit y Storyboard en Xcode**. Su objetivo es permitir al usuario ingresar los datos comerciales y de financiamiento de un producto para obtener de forma detallada el subtotal, impuestos, intereses y la cuota mensual a pagar.

La aplicación utiliza controles básicos de UIKit, como `UITextField`, `UILabel` y `UIButton`, conectados con el `ViewController` mediante `IBOutlet` e `IBAction`. La navegación y el paso de datos hacia la pantalla de resultados se gestiona mediante un segue de tipo **Show** dentro de un `UINavigationController`.

## Requerimientos Funcionales

* **RF01. Ingreso del nombre del electrodoméstico:**  
  El sistema deberá permitir al usuario ingresar mediante un campo de texto el nombre o descripción del electrodoméstico.

* **RF02. Ingreso del precio unitario:**  
  El sistema deberá permitir ingresar el precio unitario del electrodoméstico mediante un campo de texto.

* **RF03. Ingreso de la cantidad:**  
  El sistema deberá permitir ingresar la cantidad de unidades que se desean adquirir mediante un campo de texto.

* **RF04. Ingreso del plazo en meses:**  
  El sistema deberá permitir ingresar el número de meses del financiamiento mediante un campo de texto.

* **RF05. Ingreso de la tasa de interés:**  
  El sistema deberá permitir ingresar la tasa de interés mensual cobrada, expresada en porcentaje.

* **RF06. Validación de los datos:**  
  El sistema deberá verificar que los datos numéricos ingresados no estén vacíos, sean valores válidos y mayores que cero antes de realizar los cálculos y la navegación.

* **RF07. Cálculo del subtotal:**  
  El sistema deberá calcular el subtotal multiplicando el precio unitario por la cantidad de unidades ingresadas.

* **RF08. Cálculo del IGV:**  
  El sistema deberá calcular el Impuesto General a las Ventas (IGV) aplicando el 18% sobre el subtotal obtenido.

* **RF09. Cálculo de la base imponible:**  
  El sistema deberá calcular el monto base sumando el subtotal y el valor del IGV resultante.

* **RF10. Cálculo de los intereses totales:**  
  El sistema deberá calcular el monto de intereses multiplicando la base por la tasa de interés mensual (dividida entre 100) y por el número de meses del plazo.

* **RF11. Cálculo del total a pagar:**  
  El sistema deberá calcular el monto total acumulado sumando la base imponible y los intereses totales calculados.

* **RF12. Cálculo de la cuota mensual:**  
  El sistema deberá calcular el valor de la cuota mensual dividiendo el monto total a pagar entre el número de meses del plazo.

* **RF13. Envío de datos mediante Segue:**  
  El sistema deberá empaquetar los resultados en un objeto de la clase `VentaModel` y transferirlo a la pantalla de resultados usando el identificador `showResultado`.

* **RF14. Mostrar los resultados en Soles:**  
  El sistema deberá mostrar en la pantalla de resultados todos los montos calculados formateados con el símbolo de la moneda nacional peruana (`S/. %.2f`).

## Flujo principal

1. El usuario ingresa el nombre del electrodoméstico, precio unitario, cantidad, meses e interés en la pantalla **Nueva Venta**.
2. Presiona el botón **Calcular**.
3. El sistema valida que los campos de texto contengan información correcta.
4. Se ejecutan las operaciones matemáticas internas basándose en las fórmulas de venta a plazos.
5. Se guardan las 6 variables calculadas dentro de una instancia de la clase `VentaModel`.
6. Se dispara la transición visual a través del método `prepare(for:sender:)` enviando el modelo hacia adelante.
7. La pantalla de **Resultado** recibe el objeto, extrae los montos y les aplica el formato de moneda peruana.
8. Los resultados finales se muestran en los labels de la interfaz del usuario.

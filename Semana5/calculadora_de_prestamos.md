# Calculadora de Préstamos - Aplicación UIKit

## Descripción

La aplicación consiste en una calculadora de préstamos desarrollada en **Swift utilizando UIKit y Storyboard en Xcode**. Su objetivo es permitir al usuario ingresar los datos principales de un préstamo y obtener como resultado la cuota mensual y el monto total a pagar.

La aplicación utiliza controles básicos de UIKit, como `UITextField`, `UILabel` y `UIButton`, conectados con el `ViewController` mediante `IBOutlet` e `IBAction`.

## Requerimientos Funcionales

* **RF01. Ingreso del monto del préstamo:**  
  El sistema deberá permitir al usuario ingresar mediante un campo de texto el monto solicitado para el préstamo.

* **RF02. Ingreso de la tasa de interés:**  
  El sistema deberá permitir ingresar la tasa de interés anual del préstamo mediante un campo de texto.

* **RF03. Ingreso del plazo del préstamo:**  
  El sistema deberá permitir ingresar el plazo del préstamo expresado en años.

* **RF04. Validación de los datos:**  
  El sistema deberá verificar que el monto, la tasa de interés y el plazo ingresados sean valores válidos y mayores que cero antes de realizar el cálculo.

* **RF05. Cálculo de la cuota mensual:**  
  El sistema deberá calcular la cuota mensual del préstamo considerando el monto solicitado, la tasa de interés anual y el plazo ingresado.

* **RF06. Cálculo del monto total:**  
  El sistema deberá calcular el monto total que el usuario deberá pagar durante todo el plazo del préstamo.

* **RF07. Conversión de la tasa de interés:**  
  El sistema deberá convertir la tasa de interés anual ingresada por el usuario a una tasa mensual para realizar el cálculo de la cuota.

* **RF08. Conversión del plazo:**  
  El sistema deberá convertir el plazo expresado en años a la cantidad correspondiente de meses.

* **RF09. Mostrar la cuota mensual:**  
  El sistema deberá mostrar en pantalla el resultado de la cuota mensual calculada, expresado con dos decimales.

* **RF10. Mostrar el monto total:**  
  El sistema deberá mostrar en pantalla el monto total a pagar durante el periodo del préstamo, expresado con dos decimales.

* **RF11. Mostrar mensaje de validación:**  
  Si los datos ingresados no son válidos, el sistema deberá mostrar un mensaje indicando al usuario que debe ingresar valores válidos.

## Controles principales

La interfaz de la aplicación utiliza los siguientes controles de UIKit:

| Control | Identificador | Función |
|---|---|---|
| `UITextField` | `loanAmountTextField` | Ingresar el monto del préstamo |
| `UITextField` | `interestRateTextField` | Ingresar la tasa de interés anual |
| `UITextField` | `loanTermTextField` | Ingresar el plazo en años |
| `UIButton` | `calcularPrestamo` | Ejecutar el cálculo del préstamo |
| `UILabel` | `monthlyPaymentLabel` | Mostrar la cuota mensual |
| `UILabel` | `totalPaymentLabel` | Mostrar el monto total a pagar |

## Flujo principal

1. El usuario ingresa el monto del préstamo.
2. Ingresa la tasa de interés anual.
3. Ingresa el plazo del préstamo en años.
4. Presiona el botón **Calcular**.
5. El sistema valida los datos ingresados.
6. Se convierte la tasa anual a una tasa mensual y el plazo de años a meses.
7. Se calcula la cuota mensual.
8. Se calcula el monto total a pagar.
9. Los resultados se muestran en la interfaz.

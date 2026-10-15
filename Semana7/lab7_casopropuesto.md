# Explorador de Culturas Peruanas - Aplicación UIKit

## Descripción

La aplicación consiste en un explorador interactivo de culturas peruanas desarrollado en **Swift utilizando UIKit y Storyboard en Xcode**. Su objetivo es permitir a los usuarios visualizar una lista dinámica de las principales culturas preíncas del Perú y navegar hacia una pantalla de detalle para consumir información histórica enriquecida de cada una.

La aplicación implementa el patrón de arquitectura **Modelo-Vista-Controlador (MVC)**. La pantalla principal utiliza un `UITableView` con una celda personalizada para renderizar los datos de forma fluida. La navegación y la transferencia segura de objetos entre pantallas se gestiona de manera nativa mediante un segue de tipo **Show** embebido dentro de un `UINavigationController`.

## Requerimientos Funcionales

* **RF01. Definición del modelo de datos (`Cultura`):**  
  El sistema deberá contar con una clase que encapsule de forma segura las propiedades de nombre, región, descripción y una imagen representativa (`UIImage`) de cada cultura.

* **RF02. Listado dinámico mediante UITableView:**  
  El sistema deberá mostrar en la pantalla principal una lista que adapte de forma dinámica el número de filas al tamaño real del arreglo de datos mediante el protocolo `UITableViewDataSource`.

* **RF03. Implementación de Celda Personalizada:**  
  El sistema deberá utilizar una subclase de celda personalizada (`CulturaTableViewCell`) que organice de manera simétrica una imagen cuadrada y el título dentro de cada fila de la tabla.

* **RF04. Captura del evento de selección de fila:**  
  El sistema deberá detectar mediante `UITableViewDelegate` cuándo el usuario presiona una cultura, deseleccionando la fila visualmente de inmediato para mejorar la experiencia de usuario.

* **RF05. Traspaso seguro de objetos entre controladores:**  
  El sistema deberá interceptar la transición mediante el método `prepare(for:sender:)` e inyectar el objeto completo de la cultura seleccionada hacia el controlador de destino.

* **RF06. Navegación directa y sin pantallas intermedias:**  
  El sistema deberá realizar una transición limpia desde el listado general hacia el detalle, asegurando que la conexión del Segue parta desde el controlador base (`ViewController`) para evitar el renderizado de pantallas vacías.

* **RF07. Presentación de la información en el detalle:**  
  El sistema deberá mapear las propiedades del objeto recibido para colocar el nombre de la cultura en el título de la barra de navegación superior, y distribuir la región, descripción larga e imagen en los componentes de la interfaz de destino.

## Flujo principal

1. El usuario abre la aplicación y visualiza la lista con las culturas peruanas (Chavín, Paracas, Mochica y Nazca), cada una con su respectivo nombre e imagen ilustrativa en la pantalla **Lista de Culturas Peruanas**.
2. El usuario presiona sobre una de las filas de la tabla (por ejemplo, *Mochica*).
3. El sistema captura la interacción a través del delegado de la tabla y ejecuta el método de selección.
4. Se calcula el índice de la celda presionada y se extrae el objeto `Cultura` correspondiente desde el arreglo principal.
5. Se dispara la transición de pantalla (`Segue`) utilizando el identificador `irADetalle`.
6. El método de preparación intercepta el flujo, localiza al controlador destino y le transfiere la instancia del modelo con toda su información histórica interna.
7. La aplicación realiza la animación física del cambio de pantalla de forma fluida y sin ventanas intermedias vacías.
8. La pantalla de **Detalles de la Cultura** se inicializa, coloca el nombre de la cultura en el título superior del navegador y distribuye la región, descripción larga e imagen en los componentes visuales de la interfaz de usuario.
9. El usuario consume la información detallada y puede presionar el botón de retroceso superior para volver instantáneamente a la lista principal sin perder el flujo de la aplicación.

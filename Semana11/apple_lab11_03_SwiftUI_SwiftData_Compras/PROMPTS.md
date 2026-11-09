# PROMPTS.md · Laboratorio 11 · Grupo B · Caso Compras (SwiftUI + SwiftData)

Registro de las consultas hechas a la IA (Claude) durante el trabajo de la semana.
Rama del trabajo asistido: `ia-asistida` (unida luego a `main` con un pull request).

---

## Consulta 1 · Análisis de la guía
- **Fecha:** 09/11/2026
- **Contexto:** Guía del Laboratorio 11 (PDF). Nos tocó el Grupo B, Caso Compras con SwiftUI + SwiftData, Xcode 26.3.
- **Tarea:** Explicar todo lo que pide el caso Compras y confirmar si se puede trabajar solo con código (sin storyboard).
- **Restricciones:** Ceñirse a lo que dice la guía: 4 clases, 9 pantallas, roles Comprador y Supervisor, reglas de negocio y casos de prueba.
- **Formato esperado:** Resumen de requisitos y lista de dudas antes de empezar.
- **Qué hicimos con la respuesta:** La aceptamos. Respondimos las dudas: el vencimiento del crédito se cuenta desde la fecha de registro, el costo unitario lo escribe el comprador (empieza con el costo promedio), en B5 se puede elegir la fecha para probar el caso 8 y los colores del stock van en tonos azules.

## Consulta 2 · Expediente
- **Fecha:** 09/11/2026
- **Contexto:** Plantilla del anexo de la guía (9 secciones).
- **Tarea:** Redactar el expediente de forma simple pero completa.
- **Restricciones:** 2 a 3 páginas; incluir modelo con delete rules, matriz de permisos, reglas con ejemplos numéricos, pantallas, 9 + 2 casos de prueba, plan de commits y plan de uso de IA.
- **Formato esperado:** Documento editable exportable a PDF.
- **Qué hicimos con la respuesta:** La aceptamos y verificamos a mano los cálculos: IGV 216.00, total 1,416.00, costo promedio 112.00 y 115.56. Completamos los nombres de los integrantes.

## Consulta 3 · Código de la app
- **Fecha:** 09/11/2026
- **Contexto:** Proyecto `apple_lab11_03_SwiftUI_SwiftData_Compras` ya creado en Xcode (Interface SwiftUI, Storage SwiftData).
- **Tarea:** Generar el modelo (Usuario, Proveedor, Producto, Compra), el ModelContainer, la sesión @Observable, el login y registro, y las pantallas B3 a B9.
- **Restricciones:** Usuario único sin distinguir mayúsculas (se guarda en minúsculas y se valida con FetchDescriptor + #Predicate + fetchCount). Clave de mínimo 6 caracteres con confirmación. Relaciones con .deny. Filtros de Por pagar con #Predicate. IGV 18 %, aprobación desde S/ 5,000, costo promedio ponderado al aprobar y crédito a 30 días. Tema azul.
- **Formato esperado:** Archivos .swift organizados en carpetas (Models, Session, Utils, Views), con comentarios.
- **Qué hicimos con la respuesta:** La aceptamos. Compiló sin errores en el primer intento. Reemplazamos ContentView y el archivo App, y borramos Item.swift.

## Consulta 4 · Ícono y nombre de la app
- **Fecha:** 09/11/2026
- **Contexto:** La guía pide un ícono de 1024 × 1024 px y el nombre "Compras" bajo el ícono.
- **Tarea:** Diseñar el ícono y explicar dónde se configura el Display Name.
- **Restricciones:** PNG cuadrado, sin transparencia ni esquinas redondeadas, en colores azules.
- **Formato esperado:** Imagen PNG y pasos en Xcode.
- **Qué hicimos con la respuesta:** La aceptamos. Pusimos el ícono en Assets ▸ AppIcon (Any Appearance) y el Display Name en Target ▸ General ▸ Identity.

## Consulta 5 · Plan de pruebas
- **Fecha:** 09/11/2026
- **Contexto:** Los 9 casos de la guía más 2 propios.
- **Tarea:** Indicar qué datos ingresar y qué resultado esperar en cada caso.
- **Restricciones:** Los resultados deben coincidir con los de la guía.
- **Formato esperado:** Tabla paso a paso por rol.
- **Qué hicimos con la respuesta:** La modificamos. Los usuarios no venían precargados, así que creamos nuestras propias cuentas de Supervisor y Comprador. Corregimos el costo de Laptop Pro 14 (lo habíamos puesto en 1,100.00 en vez de 110.00) y creamos productos separados para los casos 4 y 5. En el caso 8 no habíamos cambiado la fecha: lo repetimos con fecha 09/09/2026. Los 11 casos dieron el resultado esperado.

## Consulta 6 · Evidencias
- **Fecha:** 09/11/2026
- **Contexto:** Capturas del simulador de todos los casos.
- **Tarea:** Agregar las capturas más importantes al expediente.
- **Restricciones:** No todas, solo las que demuestran cada regla.
- **Formato esperado:** Láminas con 3 capturas cada una y su caso.
- **Qué hicimos con la respuesta:** La aceptamos. Se agregó el anexo con 4 láminas y la tabla de resultados.

## Consulta 7 · GitHub
- **Fecha:** 09/11/2026
- **Contexto:** El repositorio tiene las ramas main, manual, ai-assisted e ia-asistida.
- **Tarea:** Explicar cómo hacer commits por partes desde Xcode y cómo llevar el trabajo a main.
- **Restricciones:** Sin perder el trabajo hecho.
- **Formato esperado:** Pasos en Xcode y comandos de git como respaldo.
- **Qué hicimos con la respuesta:** La modificamos. Subimos todo en un solo commit a `ia-asistida` en lugar de 6 commits, y lo unimos a `main` con un pull request.

---

## Cifra para el cierre conjunto de IGV
Crédito fiscal (IGV de las compras aprobadas): **S/ 1,728.00**

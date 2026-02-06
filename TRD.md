Pokédex Flutter (Mobile & Web)
Una aplicación multiplataforma construida con Flutter que permite explorar el mundo Pokémon, funcionando de manera fluida tanto online como offline.

🚀 Arquitectura y Escalabilidad
Se ha implementado una arquitectura Feature-First combinada con Clean Architecture por capas.

¿Por qué esta arquitectura?
Escalabilidad: Al separar por funcionalidades (features/pokemon_list, features/pokemon_detail), el equipo puede crecer y trabajar en diferentes módulos sin generar conflictos de código.

Independencia de la UI: La lógica de negocio reside en la capa de Domain, lo que permite cambiar el diseño o incluso el motor de base de datos sin afectar las reglas del producto.

Soporte Web: Al desacoplar la lógica en Cubits, la misma base de código alimenta una UI que se adapta a Mobile o Web mediante breakpoints.

Capas por Feature:
Domain: Entidades puras y contratos (interfaces) de repositorios.

Data: Implementaciones de repositorios, Modelos (Data Transfer Objects) y Data Sources (API/Local).

Presentation: Cubits para gestión de estado y widgets responsivos.

🧠 Gestión de Estado y Side-Effects
Se utiliza Cubit (flutter_bloc) para una gestión de estado ligera y predecible.

Flujo: UI (Evento) ➔ Cubit (Pide datos) ➔ Repository (Decide fuente) ➔ Cubit (Emite Estado) ➔ UI (Reacciona).

Desacoplamiento: La UI no sabe de dónde vienen los datos. Solo conoce los estados: Initial, Loading, Loaded y Error.

Side-effects: El manejo de errores y la persistencia se gestionan en la capa de datos, manteniendo los Cubits limpios y fáciles de testear.

📶 Offline y Caché
Estrategia: Cache First with Background Refresh
Persistencia: Se utiliza Hive/Isar para almacenar los JSONs de la API.

Lógica: Al abrir la app, se muestran instantáneamente los datos cacheados. En paralelo, se lanza una petición a la API para actualizar la información y refrescar la caché si hay cambios.

Imágenes: Implementado mediante cached_network_image, asegurando que una vez visto un Pokémon, su imagen esté disponible sin conexión.

🌐 Flutter Web & Responsividad
Decisiones clave para la experiencia Web:

Layout Adaptativo: Uso de GridView con columnas dinámicas (1 en móvil, 3-5 en web).

Interacción Desktop: Hover effects en las tarjetas y soporte para scroll de mouse/trackpad.

Optimización de Imágenes: Para evitar cientos de requests, se calcula la URL de la imagen mediante el ID del Pokémon en lugar de consultar el detalle de cada uno.

🛠️ Decisiones de Calidad (Clean Code)
Repository Pattern: Centraliza el acceso a datos, facilitando el mocking en tests.

Manejo de Errores con Either: (Uso de dartz o sellado de clases) para forzar el manejo de excepciones en la UI.

S.O.L.I.D: Inyección de dependencias vía GetIt para evitar acoplamiento rígido entre clases.

🧪 Testing
Prioridad 1 (Cubits): Test unitarios para asegurar que el flujo de estados (Loading -> Loaded) sea correcto.

Prioridad 2 (Mappers): Validar que el parseo de JSON a modelos no rompa la app ante cambios en la API.

Pendiente: Widget tests para validar el comportamiento del scroll infinito.

📝 Trade-offs y Pendientes
Por el timebox de 24h, se decidió:

Priorizar la arquitectura y el modo offline sobre animaciones complejas.

Usar una base de datos NoSQL (Hive) para agilizar la persistencia sin migraciones SQL.

Top 3 Pendientes:

Buscador con Debounce.

Sistema de Filtros por tipo de Pokémon.

Tests de Integración (E2E).

⚙️ Instrucciones de Ejecución
Clonar repositorio: git clone ...

Instalar dependencias: flutter pub get

Generar modelos (si aplica): dart run build_runner build

Ejecutar:

Mobile: flutter run

Web: flutter run -d chrome
##Autores
-Juan Camilo Agudelo
-Jeronimo Delgado
-Jose Carmona
-Sara Villegas

# GameUQ

Aplicación de consola desarrollada en Elixir para la gestión de videojuegos.

El proyecto permite administrar un inventario de videojuegos mediante operaciones CRUD
(Create, Read, Update y Delete), aplicando conceptos fundamentales de programación funcional
y estructuras de datos de Elixir.

## Objetivo

Desarrollar una aplicación de consola que permita gestionar videojuegos utilizando:

- Listas
- Mapas
- Tuplas
- Pattern Matching
- `case`
- Funciones de `Enum`
- Pipelines (`|>`)
- Inmutabilidad
- Recursividad mediante el menú de la aplicación

## Funcionalidades

La aplicación cuenta con un menú principal que permite realizar las siguientes operaciones:

1. Agregar videojuego
2. Mostrar videojuegos
3. Buscar videojuego
4. Actualizar videojuego
5. Eliminar videojuego
6. Consultar estadísticas
7. Salir

## Operaciones CRUD

### Crear

Permite registrar un nuevo videojuego solicitando:

- ID
- Nombre
- Género
- Plataforma
- Precio

El nuevo videojuego se representa mediante un mapa y se agrega a la lista de videojuegos.

### Leer

Permite:

- Mostrar todos los videojuegos registrados.
- Buscar un videojuego mediante su ID.

### Actualizar

Permite modificar los datos de un videojuego existente:

- Nombre
- Género
- Plataforma
- Precio

### Eliminar

Permite eliminar un videojuego utilizando su ID.

## Funcionalidades de Enum Utilizadas

Enum.find   :Buscar un videojuego por ID

Enum.map	:Transformar elementos y 
actualizar la lista

Enum.reject	:Eliminar elementos de la lista

Enum.filter	:Filtrar videojuegos por 
plataforma

Enum.reduce	:Calcular el valor total del inventario

Enum.count	:Contar elementos

Enum.sort_by	:Ordenar videojuegos

Enum.max	:Obtener el ID mayor


### Listas

Los videojuegos se almacenan en una lista.

```elixir
[
  %{id: 1, nombre: "FIFA 25", precio: 250000},
  %{id: 2, nombre: "GTA V", precio: 180000}
]

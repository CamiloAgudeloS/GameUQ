defmodule GameUQ do

  @moduledoc """
  Aplicacion de consola para administrar videojuegos.

  -version 1.0
  -autor: Juan Camilo Agudelo
  -fecha: 2026-09-21
  """

  @doc """
  Funcion principal de la aplicacion.
  """
  def main do
    menu([])
  end

  # El estado de la aplicacion se mantiene en la lista de videojuegos.
  # Cada opcion puede devolver una nueva lista, debido a la inmutabilidad de Elixir.

  defp menu(videojuegos) do
    IO.puts("

    +--------------------------------------+
    |              GAMEUQ                  |
    |       GESTOR DE VIDEOJUEGOS          |
    +--------------------------------------+
    |                                      |
    |  1. Agregar videojuego               |
    |  2. Mostrar videojuegos              |
    |  3. Buscar videojuego                |
    |  4. Actualizar videojuego            |
    |  5. Eliminar videojuego              |
    |  6. Estadisticas                     |
    |  7. Salir                            |
    |                                      |
    +--------------------------------------+
    ")

    opcion = Util.ingresar("Seleccione una opcion: ", :entero)

    case opcion do
      1 ->
        videojuegos
        |> crear_videojuego()
        |> menu()

      2 ->
        mostrar_videojuegos(videojuegos)
        menu(videojuegos)

      3 ->
        buscar_videojuego(videojuegos)
        menu(videojuegos)

      4 ->
        videojuegos
        |> actualizar_videojuego()
        |> menu()

      5 ->
        videojuegos
        |> eliminar_videojuego()
        |> menu()

      6 ->
        mostrar_estadisticas(videojuegos)
        menu(videojuegos)

      7 ->
        IO.puts("

        +--------------------------------------+
        |    Gracias por utilizar GameUQ       |
        |              Hasta luego             |
        +--------------------------------------+
        ")

      _ ->
        IO.puts("\nOpcion no valida.\n")
        menu(videojuegos)
    end
  end

  # Crear videojuego

  defp crear_videojuego(videojuegos) do
    IO.puts("

    +--------------------------------------+
    |         AGREGAR VIDEOJUEGO            |
    +--------------------------------------+
    ")

    id = obtener_nuevo_id(videojuegos)

    nombre = Util.ingresar("Nombre: ", :texto)
    genero = Util.ingresar("Genero: ", :texto)
    plataforma = Util.ingresar("Plataforma: ", :texto)
    precio = Util.ingresar("Precio: ", :entero)

    # El mapa representa un videojuego 
    videojuego = %{
      id: id,
      nombre: nombre,
      genero: genero,
      plataforma: plataforma,
      precio: precio
    }

    # El operador | agrega el nuevo elemento al inicio de la lista.
    nueva_lista = [videojuego | videojuegos]

    IO.puts("\nVideojuego agregado correctamente.")
    IO.puts("ID asignado: #{id}\n")

    nueva_lista
  end

  # Mostrar videojuegos

  defp mostrar_videojuegos([]) do
    IO.puts("

    +--------------------------------------+
    |        VIDEOJUEGOS REGISTRADOS       |
    +--------------------------------------+

    No hay videojuegos registrados.
    ")
  end

  defp mostrar_videojuegos(videojuegos) do
    mensaje =
      videojuegos
      # sort_by permite ordenar la lista utilizando el ID de cada mapa.
      |> Enum.sort_by(& &1.id)
      # map transforma cada videojuego en un texto para mostrarlo.
      |> Enum.map(fn videojuego ->
        "
        +--------------------------------------+
        | ID:         #{videojuego.id}
        | Nombre:     #{videojuego.nombre}
        | Genero:     #{videojuego.genero}
        | Plataforma: #{videojuego.plataforma}
        | Precio:     $#{videojuego.precio}
        +--------------------------------------+
        "
      end)
      # join une todos los textos en una sola cadena.
      |> Enum.join("\n")

    IO.puts("

    +--------------------------------------+
    |        VIDEOJUEGOS REGISTRADOS       |
    +--------------------------------------+

    #{mensaje}
    ")
  end


# Buscar videojuego

defp buscar_videojuego(videojuegos) do
  IO.puts("

  +--------------------------------------+
  |          BUSCAR VIDEOJUEGO           |
  +--------------------------------------+
  ")

  id = Util.ingresar("Ingrese el ID: ", :entero)

  # Enum.find busca el primer elemento que cumpla la condicion.
  # Si no encuentra ninguno, devuelve nil.
  resultado =
    videojuegos
    |> Enum.find(fn videojuego ->
      videojuego.id == id
    end)

  # La tupla permite representar dos posibles resultados de la busqueda:
  # {:error, mensaje} cuando no existe y {:ok, videojuego} cuando existe.
  resultado_busqueda =
    case resultado do
      nil ->
        {:error, "Videojuego no encontrado"}

      videojuego ->
        {:ok, videojuego}
    end

  # case realiza pattern matching sobre la tupla para identificar
  # si la operacion termino correctamente o produjo un error.
  case resultado_busqueda do
    {:error, mensaje} ->
      IO.puts("\nError: #{mensaje}.\n")

    {:ok, videojuego} ->
      IO.puts("

      +--------------------------------------+
      |          VIDEOJUEGO ENCONTRADO       |
      +--------------------------------------+
      | ID:         #{videojuego.id}         |
      | Nombre:     #{videojuego.nombre}     |
      | Genero:     #{videojuego.genero}     |
      | Plataforma: #{videojuego.plataforma} |
      | Precio:     $#{videojuego.precio}    |
      +--------------------------------------+
      ")
  end
end




# Actualizar videojuego

defp actualizar_videojuego(videojuegos) do
  IO.puts("

  +--------------------------------------+
  |         ACTUALIZAR VIDEOJUEGO        |
  +--------------------------------------+
  ")

  id = Util.ingresar("Ingrese el ID: ", :entero)

  # Primero se busca el videojuego para comprobar que exista.
  resultado =
    videojuegos
    |> Enum.find(fn videojuego ->
      videojuego.id == id
    end)

  resultado_actualizacion =
    case resultado do
      nil ->
        {:error, "Videojuego no encontrado"}

      videojuego ->
        nombre = Util.ingresar("Nuevo nombre: ", :texto)
        genero = Util.ingresar("Nuevo genero: ", :texto)
        plataforma = Util.ingresar("Nueva plataforma: ", :texto)
        precio = Util.ingresar("Nuevo precio: ", :entero)

        # Los mapas son inmutables. Esta sintaxis crea un nuevo mapa
        # conservando los campos que no se modifican.
        videojuego_actualizado = %{
          videojuego
          | nombre: nombre,
            genero: genero,
            plataforma: plataforma,
            precio: precio
        }

        # map recorre la lista y construye una nueva lista.
        # Solo reemplaza el elemento cuyo ID coincide.
        nueva_lista =
          videojuegos
          |> Enum.map(fn elemento ->
            if elemento.id == id do
              videojuego_actualizado
            else
              elemento
            end
          end)

        {:ok, nueva_lista}
    end

  # En caso de error se conserva la lista original.
  # En caso de exito se devuelve la nueva lista actualizada.
  case resultado_actualizacion do
    {:error, mensaje} ->
      IO.puts("\nError: #{mensaje}.\n")
      videojuegos

    {:ok, nueva_lista} ->
      IO.puts("\nVideojuego actualizado correctamente.\n")
      nueva_lista
  end
end




# Eliminar videojuego

defp eliminar_videojuego(videojuegos) do
  IO.puts("

  +--------------------------------------+
  |          ELIMINAR VIDEOJUEGO         |
  +--------------------------------------+
  ")

  id = Util.ingresar("Ingrese el ID: ", :entero)

  # find permite comprobar primero si existe el videojuego.
  resultado =
    videojuegos
    |> Enum.find(fn videojuego ->
      videojuego.id == id
    end)

  resultado_eliminacion =
    case resultado do
      nil ->
        {:error, "Videojuego no encontrado"}

      videojuego ->
        # reject crea una nueva lista excluyendo el elemento indicado.
        nueva_lista =
          videojuegos
          |> Enum.reject(fn elemento ->
            elemento.id == id
          end)

        # La tupla contiene la nueva lista y el videojuego eliminado,
        # porque ambos datos son necesarios despues de la eliminacion.
        {:ok, nueva_lista, videojuego}
    end

  case resultado_eliminacion do
    {:error, mensaje} ->
      IO.puts("\nError: #{mensaje}.\n")
      videojuegos

    {:ok, nueva_lista, videojuego} ->
      IO.puts("

      Videojuego eliminado correctamente.
      Videojuego eliminado: #{videojuego.nombre}
      ")

      nueva_lista
  end
end



  # Estadisticas

  defp mostrar_estadisticas([]) do
    IO.puts("

    +--------------------------------------+
    |             ESTADISTICAS             |
    +--------------------------------------+

    No hay videojuegos registrados.
    ")
  end

  defp mostrar_estadisticas(videojuegos) do
    # count obtiene la cantidad de elementos de la lista.
    cantidad = Enum.count(videojuegos)

    # reduce recorre todos los videojuegos y acumula sus precios
    # comenzando desde cero.
    valor_total =
      videojuegos
      |> Enum.reduce(0, fn videojuego, acumulador ->
        videojuego.precio + acumulador
      end)

    # filter conserva solamente los videojuegos cuya plataforma es PC.
    # downcase permite comparar sin importar mayusculas o minusculas.
    videojuegos_pc =
      videojuegos
      |> Enum.filter(fn videojuego ->
        String.downcase(videojuego.plataforma) == "pc"
      end)
      |> Enum.count()

    # Se ordena de mayor a menor para obtener el videojuego mas costoso.
    videojuegos_ordenados =
      videojuegos
      |> Enum.sort_by(& &1.precio, :desc)

    # hd obtiene el primer elemento de la lista ordenada.
    mas_costoso = hd(videojuegos_ordenados)

    IO.puts("

    +---------------------------------------------+
    |          ESTADISTICAS GAMEUQ                |
    +---------------------------------------------+
    |                                             |
    | Videojuegos registrados: #{cantidad}        |
    |                                             |
    | Valor total:             $#{valor_total}    |
    |                                             |
    | Videojuegos para PC:     #{videojuegos_pc}  |
    |                                             |
    | Mas costoso: #{mas_costoso.nombre}          |
    | Precio:      $#{mas_costoso.precio}         |
    |                                             |
    +---------------------------------------------+
    ")
  end

  # Generar ID

  defp obtener_nuevo_id([]) do
    1
  end

  defp obtener_nuevo_id(videojuegos) do
    # Se extraen los ID, se obtiene el mayor y se suma uno
    # para generar el siguiente identificador.
    videojuegos
    |> Enum.map(fn videojuego ->
      videojuego.id
    end)
    |> Enum.max()
    |> Kernel.+(1)
  end

end

GameUQ.main()

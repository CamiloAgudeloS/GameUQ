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

  # Menu principal

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

    videojuego = %{
      id: id,
      nombre: nombre,
      genero: genero,
      plataforma: plataforma,
      precio: precio
    }

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
      |> Enum.sort_by(& &1.id)
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

    resultado =
      videojuegos
      |> Enum.find(fn videojuego ->
        videojuego.id == id
      end)

    case resultado do
      nil ->
        resultado_busqueda = {:error, "Videojuego no encontrado"}

        case resultado_busqueda do
          {:error, mensaje} ->
            IO.puts("\nError: #{mensaje}.\n")
        end

      videojuego ->
        resultado_busqueda = {:ok, videojuego}

        case resultado_busqueda do
          {:ok, videojuego} ->
            IO.puts("

            +--------------------------------------+
            |          VIDEOJUEGO ENCONTRADO       |
            +--------------------------------------+
            | ID:         #{videojuego.id}
            | Nombre:     #{videojuego.nombre}
            | Genero:     #{videojuego.genero}
            | Plataforma: #{videojuego.plataforma}
            | Precio:     $#{videojuego.precio}
            +--------------------------------------+
            ")
        end
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

    resultado =
      videojuegos
      |> Enum.find(fn videojuego ->
        videojuego.id == id
      end)

    case resultado do
      nil ->
        resultado_actualizacion = {:error, "Videojuego no encontrado"}

        case resultado_actualizacion do
          {:error, mensaje} ->
            IO.puts("\nError: #{mensaje}.\n")
        end

        videojuegos

      videojuego ->
        nombre = Util.ingresar("Nuevo nombre: ", :texto)
        genero = Util.ingresar("Nuevo genero: ", :texto)
        plataforma = Util.ingresar("Nueva plataforma: ", :texto)
        precio = Util.ingresar("Nuevo precio: ", :entero)

        videojuego_actualizado = %{
          videojuego
          | nombre: nombre,
            genero: genero,
            plataforma: plataforma,
            precio: precio
        }

        nueva_lista =
          videojuegos
          |> Enum.map(fn elemento ->
            if elemento.id == id do
              videojuego_actualizado
            else
              elemento
            end
          end)

        resultado_actualizacion = {:ok, videojuego_actualizado}

        case resultado_actualizacion do
          {:ok, _videojuego} ->
            IO.puts("\nVideojuego actualizado correctamente.\n")
        end

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

    resultado =
      videojuegos
      |> Enum.find(fn videojuego ->
        videojuego.id == id
      end)

    case resultado do
      nil ->
        resultado_eliminacion = {:error, "Videojuego no encontrado"}

        case resultado_eliminacion do
          {:error, mensaje} ->
            IO.puts("\nError: #{mensaje}.\n")
        end

        videojuegos

      videojuego ->
        nueva_lista =
          videojuegos
          |> Enum.reject(fn elemento ->
            elemento.id == id
          end)

        resultado_eliminacion = {:ok, videojuego}

        case resultado_eliminacion do
          {:ok, videojuego} ->
            IO.puts("

            Videojuego eliminado correctamente.
            Videojuego eliminado: #{videojuego.nombre}
            ")
        end

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
    cantidad = Enum.count(videojuegos)

    valor_total =
      videojuegos
      |> Enum.reduce(0, fn videojuego, acumulador ->
        videojuego.precio + acumulador
      end)

    videojuegos_pc =
      videojuegos
      |> Enum.filter(fn videojuego ->
        String.downcase(videojuego.plataforma) == "pc"
      end)
      |> Enum.count()

    videojuegos_ordenados =
      videojuegos
      |> Enum.sort_by(& &1.precio, :desc)

    mas_costoso = hd(videojuegos_ordenados)

    IO.puts("

    +---------------------------------------------+
    |          ESTADISTICAS GAMEUQ                |
    +---------------------------------------------+
    |                                             |
    | Videojuegos registrados: #{cantidad}
    |                                             |
    | Valor total:             $#{valor_total}
    |                                             |
    | Videojuegos para PC:     #{videojuegos_pc}
    |                                             |
    | Mas costoso: #{mas_costoso.nombre}
    | Precio:      $#{mas_costoso.precio}
    |                                             |
    +---------------------------------------------+
    ")
  end

  # Generar ID

  defp obtener_nuevo_id([]) do
    1
  end

  defp obtener_nuevo_id(videojuegos) do
    videojuegos
    |> Enum.map(fn videojuego ->
      videojuego.id
    end)
    |> Enum.max()
    |> Kernel.+(1)
  end

end

GameUQ.main()

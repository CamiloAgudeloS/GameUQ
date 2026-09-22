defmodule Util do

   def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def mostrar_error(mensaje) do
    mensaje
     IO.puts(:standard_error, mensaje)
  end

  def ingresar(mensaje, :entero) do
    ingresar(mensaje, &String.to_integer/1, :entero)
  end

  def ingresar(mensaje, :real) do
    ingresar(mensaje, &String.to_float/1, :real)
  end



def ingresar(mensaje, :booleano) do

  try do

    mensaje
    |> IO.gets()
    |> String.trim()
    |> String.to_existing_atom()
    |> case do
      :true -> true
      :false -> false
    end

  rescue
    ArgumentError ->
      IO.puts("Error: Debe ingresar true o false.")
      ingresar(mensaje, :booleano)

    CaseClauseError ->
      IO.puts("Error: Debe ingresar true o false.")
      ingresar(mensaje, :booleano)
  end

end


  def ingresar(mensaje, parser, tipo_dato) do
    try do
      mensaje
      |> ingresar(:texto)
      |> parser.()
    rescue
      ArgumentError ->
        "Error: El valor ingresado no es un #{tipo_dato}. Por favor, ingrese un valor válido."
        |> mostrar_error()

        mensaje
        |> ingresar(parser, tipo_dato)
    end
  end

end

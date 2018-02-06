defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Parse and evaulate an arithmetic expression.
  String -> Number

  ## Examples
      iex> Calc.eval

  """
  def eval(exp) do
    numStack = []
    opStack = []

  end

  # String -> list of numbers and operators: +, -, *, /, (, )
  def parseExp(exp) do
    exp
    |> String.split
    |> Enum.flat_map(splitOutParen) #split "(", ")" from numbers.
  end

  @@doc """
  Split "(", ")" from numbers.
  ## Examples
    iex> Calc.splitOutParen
    iex> "((3"
    ["(", "(", "3"]
    iex> "13))"
    ["13", ")", ")"]
  """

  def splitOutParen(exp) do
    cond do
      hasOpenParen(exp) ->
        #split "(" from numbers.
      hasCloseParen(exp) ->
        #split ")" from numbers.
    end
  end

  @doc """
  Returns true iff the string starts with a "(",
  otherwise false.
  ##Examples
    iex> Calc.hasOpenParen
    iex> "((12"
    true
    iex> "12"
    false
  """
  def hasOpenParen(exp) do
    exp
    |> String.starts_with?("(")
  end

  @doc """
  Returns true iff the string ends with a ")",
  otherwise false.
  ##Examples
    iex> Calc.hasCloseParen
    iex> "12))"
    true
    iex> "12"
    false
  """
  def hasCloseParen(exp) do
    exp
    |> String.reverse
    |> String.starts_with?(")")
  end


  @doc """
  Repeatedly print a prompt, read one line,
  eval it, and print the result.

  ## Examples
      iex> Calc.main
      iex> 2 + 3
      5
      iex> 5 * 1
      5
      iex> 20 / 4
      5
      iex> 24 / 6 + (5 - 4)
      5
      iex> 1 + 3 * 3 + 1
      11

  """
  def main() do
    case IO.gets "Enter a new expression:\n" do
      :eof ->
        IO.puts "All done"
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      exp ->
        IO.puts(eval(exp))
        main()
    end
  end

end

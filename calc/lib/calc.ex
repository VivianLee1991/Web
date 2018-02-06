defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Parse and evaulate an arithmetic expression.
  String -> Number
  """
  def eval(exp) do
    numStack = []
    opStack = []
    exp
    |> parseExp
    |> calcWithStacks(numStack, opStack)
  end

  def calcWithStacks(elements, numStack, opStack) do
    [head | tail] = elements
  end


  def isNum(exp) do
    ! isOperator(exp) && !isOpenParen(exp) && !isCloseParen(exp)
  end

  def isOperator(exp) do
    exp == "+" || exp == "-" || exp == "*" || exp == "/"
  end

  def isOpenParen(exp) do
    exp == "("
  end

  def isCloseParen(exp) do
    exp == ")"
  end

  @doc """
  # String -> list of numbers and operators: +, -, *, /, (, )
  """
  def parseExp(exp) do
    exp
    |> String.split
    |> Enum.flat_map(fn (x) -> splitOutParen(x) end) #split "(", ")" from numbers.
  end

  @doc """
  Split "(", ")" from numbers.
  """
  def splitOutParen(exp) do
    cond do
      hasOpenParen(exp) ->
        splitOpenParen(exp, [])  #split "(" from numbers.
      hasCloseParen(exp) ->
        splitCloseParen(exp, []) #split ")" from numbers.
      true -> [exp]
    end
  end

  @doc """
  Split "(" from numbers.
  """
  def splitOpenParen(exp, lst) do
    if hasOpenParen(exp) do
      "(" <> newExp = exp
      newLst = lst ++ ["("]
      splitOpenParen(newExp, newLst)
    else
      lst ++ [exp]
    end
  end

  @doc """
  Split ")" from numbers.
  """
  def splitCloseParen(exp, lst) do
    if hasCloseParen(exp) do
      newExp = String.replace_suffix(exp, ")", "")
      newLst = [")"] ++ lst
      splitCloseParen(newExp, newLst)
    else
      [exp] ++ lst
    end
  end

  @doc """
  Returns true iff the string starts with a "(",
  otherwise false.
  """
  def hasOpenParen(exp) do
    exp
    |> String.starts_with?("(")
  end

  @doc """
  Returns true iff the string ends with a ")",
  otherwise false.
  """
  def hasCloseParen(exp) do
    exp
    |> String.ends_with?(")")
  end

  @doc """
  Repeatedly print a prompt, read one line,
  eval it, and print the result.
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

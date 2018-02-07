defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Parse and evaulate an arithmetic expression.
  String -> Number
  """
  def eval(exp) do
    exp
    |> parseExp
    |> Enum.map(fn(x) ->   # convert string representing a number to the number
        if isNum?(x) do
          String.to_integer(x)
        end
      end)
    |> calcWithStacks([], [])
  end

  @doc """
  """
  def calcWithStacks(elements, numStack, opStack) do
    if elements == [] do
      #compute until opStack is empty
      calToEnd(numStack, opStack)

    else
      [head | elements] = elements
      cond do
        isNum?(head) ->
          numStack = [head] ++ numStack

        isOperator?(head) ->
          if opStack == [] || priorTo(head, hd(opStack)) do
            opStack = [head] ++ opStack
          else
            {numStack, opStack} = calcOnce(numStack, opStack)
            opStack = [head] ++ opStack
          end

        isOpenParen?(head) ->
          opStack = [head] ++ opStack

        isCloseParen?(head) ->
          {numStack, opStack} = calcAllInParen(numStack, opStack)
      end

      calcWithStacks(elements, numStack, opStack)
    end
  end

  @doc """
  Returns true if op1 is prior to op2, otherwise false
  """
  def priorTo(op1, op2, priority \\ %{"+" => 1, "-" => 1, "*" => 2, "/" => 2}) do
    priority[op1] > priority[op2]
  end

  @doc """
  Calculate one expression in stacks.
  Returns a tuple of updated {numStack, opStack}
  """
  def calcOnce(numStack, opStack) do
    # pop 2 nums and 1 operator
    {num2, numStack} = List.pop_at(numStack, 0)
    {num1, numStack} = List.pop_at(numStack, 0)
    {op, opStack} = List.pop_at(opStack, 0)
    # calculate the result and push back to numStack
    numStack = [calculate(num1, num2, op)] ++ numStack
    {numStack, opStack}
  end

  @doc """
  Calculate all the expressions in current parenthesis.
  """
  def calcAllInParen(numStack, opStack) do
    if isOpenParen?(hd(opStack)) do
      opStack = List.delete_at(opStack, 0)
      {numStack, opStack}
    else
      {numStack, opStack} = calcOnce(numStack, opStack)
      calcAllInParen(numStack, opStack)
    end
  end

  @doc """
  Calculate the left expressions in the stacks.
  """
  def calToEnd(numStack, opStack) do
    if opStack != [] do
      {numStack, opStack} = calcOnce(numStack, opStack)
      # continues
      calToEnd(numStack, opStack)
    else  # end of the calculation
      hd numStack
    end
  end

  @doc """
  Calculate four basic arithmetic expressions.
  Do integer division for "/"
  """
  def calculate(oprand1, oprand2, op) do
    cond do
      op == "+" -> oprand1 + oprand2
      op == "-" -> oprand1 - oprand2
      op == "*" -> oprand1 * oprand2
      op == "/" -> div(oprand1, oprand2)
      true -> "Invalid operator"
    end
  end

  def isNum?(exp) do
    !isOperator?(exp) && !isOpenParen?(exp) && !isCloseParen?(exp)
  end

  def isOperator?(exp) do
    exp == "+" || exp == "-" || exp == "*" || exp == "/"
  end

  def isOpenParen?(exp) do
    exp == "("
  end

  def isCloseParen?(exp) do
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
      hasOpenParen?(exp) ->
        splitOpenParen(exp, [])  #split "(" from numbers.
      hasCloseParen?(exp) ->
        splitCloseParen(exp, []) #split ")" from numbers.
      true -> [exp]
    end
  end

  @doc """
  Split "(" from numbers.
  """
  def splitOpenParen(exp, lst) do
    if hasOpenParen?(exp) do
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
    if hasCloseParen?(exp) do
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
  def hasOpenParen?(exp) do
    exp
    |> String.starts_with?("(")
  end

  @doc """
  Returns true iff the string ends with a ")",
  otherwise false.
  """
  def hasCloseParen?(exp) do
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

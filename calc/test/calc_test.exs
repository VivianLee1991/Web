defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "eval" do
    assert Calc.eval() == :world
  end
end

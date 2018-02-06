defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "eval" do
    assert Calc.eval("3 + 1") == ["3 + 1"]
  end

  test "parse arithmetic expressions" do
    assert Calc.parseExp("5 - 1") == ["5", "-", "1"]
    assert Calc.parseExp("1 / (2 * (3 - 1))")
            == ["1", "/", "(", "2", "*", "(", "3", "-", "1", ")", ")"]
  end

  test "split out open / close paren" do
    assert Calc.splitOutParen("((3") == ["(", "(", "3"]
    assert Calc.splitOutParen("13)))") == ["13", ")", ")", ")"]
  end

  test "split open paren" do
    assert Calc.splitOpenParen("((12", []) == ["(", "(", "12"]
    assert Calc.splitOpenParen("12", []) == ["12"]
  end

  test "split close paren" do
    assert Calc.splitCloseParen("13)))", []) == ["13", ")", ")", ")"]
    assert Calc.splitCloseParen("13", []) == ["13"]
  end

  test "has open paren?" do
    assert Calc.hasOpenParen("((12") == true
    assert Calc.hasOpenParen("(12") == true
    assert Calc.hasOpenParen("12") == false
  end

  test "has close paren?" do
    assert Calc.hasCloseParen("12)))") == true
    assert Calc.hasCloseParen("12)") == true
    assert Calc.hasCloseParen("12") == false
  end
end

defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "eval" do
    assert Calc.eval("1 + (2 * (3 - 1))") == 5
    assert Calc.eval("5 - 2") == 3
    assert Calc.eval("5 + 3") == 8
    assert Calc.eval("5 / 1") == 5
    assert Calc.eval("5 / 2") == 2
    assert Calc.eval("5 + 2 * 3") == 11
    assert Calc.eval("5 + 2 * 3 / 2") == 8
    assert Calc.eval("3 + (5 + 2)") == 10
    assert Calc.eval("(5 + 2) * 3") == 21
    assert Calc.eval("(3 + (5 * 1)) - 1") == 7  
  end

  test "calculate one expression in stacks" do
    assert Calc.calcOnce([2, 3, 1], ["*", "+"]) == {[6, 1], ["+"]}
  end

  test "calculate to the end of stacks" do
    assert Calc.calToEnd([2, 3, 1], ["*", "+"]) == 7
    assert Calc.calToEnd([2, 3, 1], ["+", "+"]) == 6
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
    assert Calc.hasOpenParen?("((12") == true
    assert Calc.hasOpenParen?("(12") == true
    assert Calc.hasOpenParen?("12") == false
  end

  test "has close paren?" do
    assert Calc.hasCloseParen?("12)))") == true
    assert Calc.hasCloseParen?("12)") == true
    assert Calc.hasCloseParen?("12") == false
  end
end

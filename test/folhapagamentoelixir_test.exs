defmodule FolhapagamentoelixirTest do
  use ExUnit.Case
  doctest Folhapagamentoelixir

  test "Calcular INSS" do
    assert Folhapagamentoelixir.calcular_inss() == :inss
  end

  test "Calcular FGTS" do
    assert Folhapagamentoelixir.calcular_fgts() == :fgts
  end

  test "Calcular dependentes" do
    assert Folhapagamentoelixir.calcular_dependentes() == :dependentes
  end

  test "Calcular IRRF" do
    assert Folhapagamentoelixir.calcular_irrf() == :irrf
  end

  test "Calcular Horas Extras" do
    assert Folhapagamentoelixir.calcular_horas_extras() == :horas_extras
  end

  test "Calcular DSR (Descanso Semanal Remunerado)" do
    assert Folhapagamentoelixir.calcular_dsr() == :dsr
  end

  test "Calcular vale transporte" do
    assert Folhapagamentoelixir.calcular_vale_transporte() == :vale_transporte
  end

  test "Calcular vale alimentação" do
    assert Folhapagamentoelixir.calcular_vale_alimentacao() == :vale_alimentacao
  end

  test "Calcular adicional noturno" do
    assert Folhapagamentoelixir.calcular_adicional_noturno() == :adicional_noturno
  end

  test "Calcular adicional insalubridade" do
    assert Folhapagamentoelixir.calcular_adicional_insalubridade() == :adicional_insalubridade
  end

  test "Calcular Salario Liquido" do
    assert Folhapagamentoelixir.calcular_salario_liquido() == :salario_liquido
  end
end

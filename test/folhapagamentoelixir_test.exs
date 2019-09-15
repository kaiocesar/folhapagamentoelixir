defmodule FolhapagamentoelixirTest do
  use ExUnit.Case
  doctest Folhapagamentoelixir

  @valid_attrs [%{
      :nome => "Brains Adams",
      :salario_base => 3000,
      :base_horas => 220,
      :jornada => %{
        :inicio => 8,
        :refeicao => 60,
        :termino => 17
      },
      :insalubridade => "média",
      :periculosidade => 0.30,
      :dependentes => 2,
      :horas_extras => %{
        :domingos_feriados => 1,
        :dias_uteis => 2
      }
    }
  ]

  describe "# Calculo do INSS: " do
    test "Salario base de R$3.000,00 (aliquota de 11%)" do
      [head] = @valid_attrs
      assert Folhapagamentoelixir.calcular_inss(head[:salario_base]) == 330.0
    end

    test "Salario base de R$1.751,81  (aliquota de 8%)" do
      assert Folhapagamentoelixir.calcular_inss(1751.81) == 140.14
    end

    test "Salario base de R$1.751.82  (aliquota de 9%)" do
      assert Folhapagamentoelixir.calcular_inss(1751.82) == 157.66
    end

    test "Salario base de R$2.919,73  (aliquota de 11%)" do
      assert Folhapagamentoelixir.calcular_inss(2919.73) == 321.17
    end

    test "Salario base de R$5.839,46  (Teto)" do
      assert Folhapagamentoelixir.calcular_inss(5839.46) == 642.34
    end

    test "Salario base igual a ZERO" do
      assert Folhapagamentoelixir.calcular_inss(0) == 0
    end

    test "Salario base negativo" do
      assert Folhapagamentoelixir.calcular_inss(-1) == nil
    end
  end

  describe "# Calculo do FGTS: " do
    test "Salario base de R$3.000,00" do
      [head] = @valid_attrs
      assert Folhapagamentoelixir.calcular_fgts(head[:salario_base]) == 240.0
    end

    test "Salario base igual a zero" do
      assert Folhapagamentoelixir.calcular_fgts(0) == 0
    end

    test "Salario base igual a -1" do
      assert Folhapagamentoelixir.calcular_fgts(-1) == nil
    end

    test "Salario base igual a alphanumeric" do
      assert Folhapagamentoelixir.calcular_fgts("32154") == nil
    end
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

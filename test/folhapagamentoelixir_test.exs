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

  describe "# Calculo de dependentes: " do
    test "Dois dependentes" do
      assert Folhapagamentoelixir.calcular_dependentes(2) == 379.18
    end
    test "Nenhum dependente" do
      assert Folhapagamentoelixir.calcular_dependentes(0) == 0
    end
  end

  describe "# Calculo do IRRF" do
    test "Salário de R$1.500,00 e 1 dependente (aliquota nula)" do
      valor_inss = Folhapagamentoelixir.calcular_inss(1500)
      assert Folhapagamentoelixir.calcular_dependentes(1)
             |> Folhapagamentoelixir.calcular_irrf(valor_inss, 1500) == 0
    end
    test "Salário de R$3.000,00 e 2 dependentes (aliquota 7,5%)" do
      valor_inss = Folhapagamentoelixir.calcular_inss(3000)
      assert Folhapagamentoelixir.calcular_dependentes(2)
             |> Folhapagamentoelixir.calcular_irrf(valor_inss, 3000) == 29.01
    end
    test "Salário de R$3.800,00 e 2 dependentes (aliquota 15%)" do
      valor_inss = Folhapagamentoelixir.calcular_inss(3800)
      assert Folhapagamentoelixir.calcular_dependentes(2)
             |> Folhapagamentoelixir.calcular_irrf(valor_inss, 3800) == 95.62
    end
    test "Salário de R$4.600,00 e nenhum dependente (aliquota 22,5%)" do
      valor_inss = Folhapagamentoelixir.calcular_inss(4600)
      assert Folhapagamentoelixir.calcular_dependentes(0)
             |> Folhapagamentoelixir.calcular_irrf(valor_inss, 4600) == 285.02
    end
  end

  test "Calcular Horas Extras" do
    # dias uteis 24 -> dsr 5
    assert Folhapagamentoelixir.calcular_horas_extras(1000, 220, 10, 4) == %{:he_normal => 68.18, :he_domingos => 36.36, :total_he => 104.55}
  end

  test "Calcular DSR (Descanso Semanal Remunerado)" do
    assert Folhapagamentoelixir.calcular_dsr() == :dsr
  end

  describe "Calculo de vale transporte" do
    test "Salário base de R$3.000,00 com necessidade de VT de R$228,80 por mês" do
      assert Folhapagamentoelixir.calcular_vale_transporte(3000, 228.80) == %{:vale_transporte => 228.80, :aux_transporte => 48.80}
    end
  end

  test "Calcular vale alimentação" do
    assert Folhapagamentoelixir.calcular_vale_alimentacao(3000) == 600.0
  end

  describe "Calculo de adicional noturno" do
    test "Salário de R$3.000,00 com jornada de 220 horas/mês" do
      assert Folhapagamentoelixir.calcular_adicional_noturno(3000, 220) == 16.36
    end
    test "Sálário de R$1.200,00 com jornada de 180 horas/mês" do
      assert Folhapagamentoelixir.calcular_adicional_noturno(1200, 180) == 8
    end
  end

  describe "Calcular adicional insalubridade" do
    test "grau mínimo" do
      assert Folhapagamentoelixir.calcular_adicional_insalubridade("mínimo") == 99.8
    end
    test "grau médio" do
      assert Folhapagamentoelixir.calcular_adicional_insalubridade("médio") == 199.6
    end
    test "grau máximo" do
      assert Folhapagamentoelixir.calcular_adicional_insalubridade("máximo") == 399.2
    end
  end

  test "Calcular Salario Liquido" do
    assert Folhapagamentoelixir.calcular_salario_liquido() == :salario_liquido
  end
end

defmodule Folhapagamentoelixir do
  @moduledoc """
  Documentation for Folhapagamentoelixir.
  """

  @doc """
  Folha de pagamento com Elixir.

  ## Examples

      iex> Folhapagamentoelixir.calcular_inss(3000)
      330.0

      iex> Folhapagamentoelixir.calcular_fgts(3000)
      240.0

      iex> Folhapagamentoelixir.calcular_dependentes(2)
      379.18

      iex> Folhapagamentoelixir.calcular_irrf(379.18, 330, 3000)
      29.01

      iex> Folhapagamentoelixir.calcular_horas_extras()
      :horas_extras

      iex> Folhapagamentoelixir.calcular_dsr()
      :dsr

      iex> Folhapagamentoelixir.calcular_vale_transporte(3000, 228.80)
      %{:vale_transporte => 228.80, :aux_transporte => 48.80}

      iex> Folhapagamentoelixir.calcular_vale_alimentacao(3000)
      600.0

      iex> Folhapagamentoelixir.calcular_adicional_noturno()
      :adicional_noturno

      iex> Folhapagamentoelixir.calcular_adicional_insalubridade()
      :adicional_insalubridade

      iex> Folhapagamentoelixir.calcular_salario_liquido()
      :salario_liquido

  """


  def calcular_inss (salario_base) do
    cond do
      salario_base < 0 or not is_number(salario_base) ->
        nil
      salario_base <= 1751.81 ->
        Float.round(salario_base * (8/100), 2)
      salario_base >= 1751.82 and salario_base <= 2919.72 ->
        Float.round(salario_base * (9/100), 2)
      salario_base >= 2919.73 and salario_base <= 5839.45 ->
        Float.round(salario_base * (11/100), 2)
      salario_base > 5839.45 ->
        642.34
    end
  end

  def calcular_fgts(salario_base) do
    if is_number(salario_base) and salario_base >= 0 do
      salario_base * (8/100)
    end
  end

  def calcular_dependentes(qtd_dependentes) when is_number(qtd_dependentes) do
    qtd_dependentes * 189.59
  end

  def calcular_irrf(valor_dependentes, valor_inss, salario_base) do
    salario_descontado = salario_base - valor_inss - valor_dependentes
    cond do
      salario_descontado <= 1903.98 ->
        0
      salario_descontado >= 1903.99 and salario_descontado <= 2826.65 ->
        Float.round((salario_descontado * 0.075) - 142.80, 2)
      salario_descontado >= 2826.66 and salario_descontado <= 3751.05 ->
        Float.round((salario_descontado * 0.15) - 354.80, 2)
      salario_descontado >= 3751.06 and salario_descontado <= 4664.68 ->
        Float.round((salario_descontado * 0.225) - 636.13, 2)
      salario_descontado >= 4664.69 ->
        Float.round((salario_descontado * 0.275) - 869.36, 2)
    end
  end

  def calcular_horas_extras do
    :horas_extras
  end

  def calcular_dsr do
    :dsr
  end

  def calcular_vale_transporte(salario_base, vt_necessario) do
    vt_base = Float.round(salario_base * 0.06, 2)
    cond do
      vt_base < vt_necessario -> %{:vale_transporte => vt_necessario, :aux_transporte => Float.round((vt_necessario - vt_base), 2)}
      vt_base >= vt_necessario -> %{:vale_transporte => vt_necessario, :aux_transporte => 0}
    end
  end

  def calcular_vale_alimentacao(salario_base) do
    Float.round(salario_base * 0.20, 2)
  end

  def calcular_adicional_noturno do
    :adicional_noturno
  end

  def calcular_adicional_insalubridade do
    :adicional_insalubridade
  end

  def calcular_salario_liquido do
    :salario_liquido
  end
end

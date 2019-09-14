defmodule Folhapagamentoelixir do
  @moduledoc """
  Documentation for Folhapagamentoelixir.
  """

  @doc """
  Folha de pagamento com Elixir.

  ## Examples

      iex> Folhapagamentoelixir.calcular_inss(3000)
      330.0

      iex> Folhapagamentoelixir.calcular_fgts()
      :fgts

      iex> Folhapagamentoelixir.calcular_dependentes()
      :dependentes

      iex> Folhapagamentoelixir.calcular_irrf()
      :irrf

      iex> Folhapagamentoelixir.calcular_horas_extras()
      :horas_extras

      iex> Folhapagamentoelixir.calcular_dsr()
      :dsr

      iex> Folhapagamentoelixir.calcular_vale_transporte()
      :vale_transporte

      iex> Folhapagamentoelixir.calcular_vale_alimentacao()
      :vale_alimentacao

      iex> Folhapagamentoelixir.calcular_adicional_noturno()
      :adicional_noturno

      iex> Folhapagamentoelixir.calcular_adicional_insalubridade()
      :adicional_insalubridade

      iex> Folhapagamentoelixir.calcular_salario_liquido()
      :salario_liquido

  """


  def calcular_inss (salario_base) do
    cond do
      salario_base <= 1751.81 ->
        salario_base * (8/100)
      salario_base >= 1751.82 and salario_base <= 2919.72 ->
        salario_base * (9/100)
      salario_base >= 2919.73 and salario_base <= 5839.45 ->
        salario_base * (11/100)
      salario_base > 5839.45 ->
        642.34
    end
  end

  def calcular_fgts do
    :fgts
  end

  def calcular_dependentes do
    :dependentes
  end

  def calcular_irrf do
    :irrf
  end

  def calcular_horas_extras do
    :horas_extras
  end

  def calcular_dsr do
    :dsr
  end

  def calcular_vale_transporte do
    :vale_transporte
  end

  def calcular_vale_alimentacao do
    :vale_alimentacao
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

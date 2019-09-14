defmodule Folhapagamentoelixir do
  @moduledoc """
  Documentation for Folhapagamentoelixir.
  """

  @doc """
  Folha de pagamento com Elixir.

  ## Examples

      iex> Folhapagamentoelixir.calcular_inss()
      :inss

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

  funcionarios = [
    %{
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

  def calcular_inss do
    :inss
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

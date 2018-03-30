defmodule Credo.CLI.Command.Info.Output.Default do
  alias Credo.Execution
  alias Credo.CLI.Output.UI

  def print(%Execution{verbose: true}, info) do
    info
    |> verbose_info()
    |> UI.puts()
  end

  def print(_exec, info) do
    info
    |> basic_info()
    |> UI.puts()
  end

  defp basic_info(info) do
    """
    System:
      Credo: #{info["system"]["credo"]}
      Elixir: #{info["system"]["elixir"]}
      Erlang: #{info["system"]["erlang"]}
    """
    |> String.trim()
  end

  defp verbose_info(info) do
    """
    #{basic_info(info)}
    Configuration:
      Checks:#{Enum.map(info["config"]["checks"], &list_entry/1)}
      Files:#{Enum.map(info["config"]["files"], &list_entry/1)}
    """
    |> String.trim()
  end

  defp list_entry(name) do
    "\n    - #{name}"
  end
end
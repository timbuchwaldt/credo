defmodule Mix.Tasks.Credo.Exec do
  use Mix.Task

  @shortdoc  "Run code analysis (use `--help` for options)"
  @moduledoc @shortdoc

  @doc false
  def run(_argv) do
    Credo.Execution.Group.call(%Credo.Execution{})
  end
end

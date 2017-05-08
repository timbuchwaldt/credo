defmodule Credo.Execution.Task do
  defmacro __using__(_opts \\ []) do
    quote do
      import Credo.Execution
    end
  end
end

defmodule Credo.Execution.TaskBuilder do
  defmacro __using__(_opts \\ []) do
    quote do
      import Credo.Execution.TaskBuilder
      Module.register_attribute(__MODULE__, :tasks, accumulate: true)
      @before_compile Credo.Execution.TaskBuilder

      def call(exec) do
        task_builder_call(exec)
      end
    end
  end

  @doc false
  defmacro __before_compile__(_env) do
    quote do
      defp task_builder_call(exec) do
        tasks = Enum.reverse(@tasks)
        IO.inspect({:tasks, tasks})

        Enum.reduce(tasks, exec, fn(group, exec) ->
          apply(group, :call, [exec])
        end)
      end
    end
  end

  defmacro task(atom) do
    quote do
      @tasks unquote(atom)
    end
  end
end

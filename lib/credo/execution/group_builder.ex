defmodule Credo.Execution.GroupBuilder do
  defmacro __using__(_opts \\ []) do
    quote do
      import Credo.Execution.GroupBuilder
      Module.register_attribute(__MODULE__, :groups, accumulate: true)
      @before_compile Credo.Execution.GroupBuilder

      def call(exec) do
        group_builder_call(exec)
      end
    end
  end

  @doc false
  defmacro __before_compile__(_env) do
    quote do
      defp group_builder_call(exec) do
        groups = Enum.reverse(@groups)
        IO.inspect({:groups, groups})

        Enum.reduce(groups, exec, fn(group, exec) ->
          IO.puts ""
          IO.inspect({:group, group})

          apply(group, :call, [exec])
        end)
      end
    end
  end

  defmacro group(name, group_opts) do
    module_name = :"Credo.ExGroups.#{name}"
    group_name = name

    quote do
      @groups unquote(module_name)

      defmodule unquote(module_name) do
        use Credo.Execution.TaskBuilder

        unquote(group_opts[:do])

        def name, do: unquote(group_name)
      end
    end
  end
end

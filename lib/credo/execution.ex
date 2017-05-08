defmodule Credo.Execution do
  @doc """
  For every run Credo creates a `Struct` struct, which is
  manipulated and handed "down" throughout the execution of credo.
  """

  defstruct cli_options:        nil,
            config:             nil,
            checks:             nil,
            skipped_checks:     nil,
            phases:             [],
            phases_results:     %{},
            assigns:            %{},  # assigns for internal use per run
            results:            %{},  # this contains information that gets rendered to the terminal
            lint_attribute_map: %{}   # maps filenames to @lint attributes

  def put_assign(%__MODULE__{assigns: assigns} = exec, name, value) do
    %__MODULE__{exec | assigns: Map.put(assigns, name, value)}
  end
end

defmodule TemporaryMacros do
  defmacro phase(stuff, block), do: false
end

defmodule Credo.Token do
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

  import TemporaryMacros

  phase :parse_cli_options do
    run ParseCLIOptions
  end

  phase :validate_cli_options do
    run ValidateCLIOptions
  end

  phase :convert_cli_options_to_config do
    run ConvertCLIOptionToConfig
    run PutConfigIntoToken
  end

  phase :validate_config do
    run ValidateConfig
  end

  phase :resolve_config do
    run UseColors
    run CheckForUpdates
    run RequireRequires
  end

  phase :validate_command do
    run PutCommandIntoToken
  end

  phase :run_command do
    run RunCommand
  end

  phase :convert_results do
    run ConvertResults
  end

  phase :present_results do
    run PrintResults
  end

  phase phase :halt_execution do do
    run ToExitStatus
    run HaltIfFailed
  end
end

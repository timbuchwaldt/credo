
defmodule Credo.Execution.Group do
  use Credo.Execution.GroupBuilder

  group :parse_cli_options do
    task ParseCLIOptions
  end

  group :validate_cli_options do
    task ValidateCLIOptions
  end

#  group :convert_cli_options_to_config do
#    task ConvertCLIOptionToConfig
#    task PutConfigIntoToken
#  end

#  group :validate_config do
#    task ValidateConfig
#  end

#  group :resolve_config do
#    task UseColors
#    task CheckForUpdates
#    task RequireRequires
#  end

#  group :validate_command do
#    task PutCommandIntoToken
#  end

#  group :task_command do
#    task taskCommand
#  end

#  group :convert_results do
#    task ConvertResults
#  end

#  group :present_results do
#    task PrintResults
#  end

#  group :halt_execution do
#    task ToExitStatus
#    task HaltIfFailed
#  end
end

defmodule ParseCLIOptions do
  use Credo.Execution.Task

  def call(exec, _opts \\ []) do
    exec
  end
end

defmodule ValidateCLIOptions do
  use Credo.Execution.Task

  def call(exec, _opts \\ []) do
    put_assign(exec, "test", "ignore")
  end
end

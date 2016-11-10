ExUnit.start

{:ok, files} = File.ls("./lib/kv")

Enum.each files, fn(file) ->
  Code.require_file "../lib/kv/#{file}", __DIR__
end

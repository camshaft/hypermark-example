-module(hypermark_example_middleware).

-export([resolve/1]).

resolve(logger) ->
  hypermark_process_logger:init([]);
resolve(Module) ->
  {error, {undef, Module}}.

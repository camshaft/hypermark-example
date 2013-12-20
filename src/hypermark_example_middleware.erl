-module(hypermark_example_middleware).

-export([resolve/3]).

resolve(logger) ->
  fun hypermark_process_logger:execute/2;
resolve(Module) ->
  erlang:error(no_resolution, [Module]).

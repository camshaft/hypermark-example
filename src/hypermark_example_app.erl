-module(hypermark_example_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  %% Start any protocols
  ok = hypermark_example_protocols:start_protocols(hypermark_example),
  simple_sup:start_link(hypermark_example_processes:child_specs(hypermark_example)).

stop(_State) ->
  ok = hypermark_cowboy_protocol:stop_protocol(hypermark_example_protocol_http),
  ok.

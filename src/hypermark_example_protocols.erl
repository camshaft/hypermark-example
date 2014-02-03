-module(hypermark_example_protocols).

-export([start/0]).
-export([start_protocols/1]).
-export([stop_protocols/1]).

start() ->
  ok = hypermark_example_http_protocol:start(),
  ok.

start_protocols(App) ->
  ok = hypermark_example_http_protocol:start_protocol(App),
  ok.

stop_protocols(App) ->
  ok = hypermark_example_http_protocol:stop_protocol(App),
  ok.

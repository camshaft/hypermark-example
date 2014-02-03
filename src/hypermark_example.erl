-module(hypermark_example).

-export([start/0]).
-export([serializers/0]).
-export([deserializers/0]).
-export([commands/0]).
-export([providers/0]).

start() ->
  ok = hypermark_example_protocols:start(),
  application:start(hypermark_example).

serializers() ->
  hypermark_example_serializers.

deserializers() ->
  hypermark_example_deserializers.

commands() ->
  hypermark_example_commands.

providers() ->
  hypermark_example_providers.

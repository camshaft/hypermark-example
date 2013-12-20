-module(hypermark_example_protocol_http).

-export([providers/0]).
-export([providers/1]).

providers() ->
  [{input, hypermark_cowboy_input}, {auth, hypermark_cowboy_simple_secrets}].

providers(input) ->
  hypermark_cowboy_input;
providers(auth) ->
  hypermark_cowboy_simple_secrets;
providers(Provider) ->
  erlang:error({missing_provider, Provider}).

port() ->
  simple_env:get("PORT").

routes() ->
  [
    [
      {resource, index},
      {action, init},
      {config, [
        {method, "GET"},
        {path, "/"}
      ]}
    ],
    [
      {resource, app},
      {action, list},
      {config, [
        {method, "GET"},
        {path, "/apps"}
      ]}
    ],
    [
      {resource, app},
      {action, create},
      {config, [
        {method, "POST"},
        {path, "/apps"}
      ]}
    ],
    [
      {resource, app},
      {action, read},
      {config, [
        {method, "GET"},
        {path, "/apps/:app"}
      ]}
    ],
  ].

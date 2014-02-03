-module(hypermark_example_http_protocol).

-export([start/0]).
-export([start_protocol/1]).
-export([stop_protocol/1]).
-export([port/0]).
-export([routes/0]).

start() ->
  hypermark_cowboy_protocol:start().

start_protocol(App) ->
  hypermark_cowboy_protocol:start_protocol(?MODULE, App).

stop_protocol(App) ->
  hypermark_cowboy_protocol:stop_protocol(?MODULE, App).

port() ->
  8080.
  %% TODO simple_env:get("PORT").

routes() ->
  [
    [
      {resource, index},
      {action, 'init'},
      {config, [
        {method, "GET"},
        {path, "/"}
      ]}
    ],
    [
      {resource, users},
      {action, 'read'},
      {config, [
        {method, "GET"},
        {path, "/users/:user"}
      ]}
    ],
    [
      {resource, app},
      {action, 'list'},
      {config, [
        {method, "GET"},
        {path, "/apps"}
      ]}
    ],
    [
      {resource, app},
      {action, 'create'},
      {config, [
        {method, "POST"},
        {path, "/apps"}
      ]}
    ],
    [
      {resource, app},
      {action, 'read'},
      {config, [
        {method, "GET"},
        {path, "/apps/:app"}
      ]}
    ]
  ].

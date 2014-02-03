-module(hypermark_example_process_users).

-export([start_link/0]).
-export([get/3]).
-export([relation_to/3]).

start_link() ->
  hypermark_process_local:start_link(?MODULE, []).

get(Req, Env, [_A, _B]) ->
  hypermark_process_local:execute(get, Req, Env, fun() ->
    estack:execute(Req, Env, [
      hypermark_example_middleware:resolve(memoize)

    ])
  end).

relation_to(Req, Env, [_A, _B]) ->
  estack:execute(Req, Env, [
    hypermark_example_middleware:resolve(memoize)

  ]).

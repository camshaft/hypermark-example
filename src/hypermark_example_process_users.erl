-module(hypermark_example_process_users).

start_link() ->
  hypermark_process_local:start_link(?MODULE, []).

get(Req, Env, [A, B]) ->
  hypermark_process_local:execute(get, Req, Env, fun() ->
    estack:execute(Req, Env, [
      hypermark_example_middleware:resolve(memoize),

    ])
  end).

relation_to(Req, Env, [A, B]) ->
  estack:execute(Req, Env, [
    hypermark_example_middleware:resolve(memoize),

  ]).

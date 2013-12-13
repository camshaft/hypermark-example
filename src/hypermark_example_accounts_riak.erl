-module(hypermark_example_accounts_riak).

-export([get/2]).

get(_ID, _Env) ->
  [{username, <<"CamShaft">>}].


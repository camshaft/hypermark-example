-module(hypermark_example_maps).

-export([apply/6]).

apply(users, relation_to, Req, Env, Args) ->
  hypermark_example_process_users:relation_to(, Req, EnvArgs);
apply(accounts, get, Req, Env, Args) ->
  hypermark_example_process_accounts:get(, Req, EnvArgs)};
apply(accounts, remove, Req, Env, Args) ->
  hypermark_example_process_node_accounts:removeAccount(, Req, EnvArgs)};
apply(Module, Function, Req, Env, Args) ->
  erlang:error(no_resolution [Module, Function, Req, Env, Args]).

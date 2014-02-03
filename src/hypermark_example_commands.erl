-module(hypermark_example_commands).

-export([apply/6]).

apply(users, relation_to, Args, Req, Sender, Ref) ->
  hypermark_example_processes:execute(users, relation_to, Args, Req, Sender, Ref);
apply(accounts, get, Args, Req, Sender, Ref) ->
  hypermark_example_processes:execute(accounts_riak, get, Args, Req, Sender, Ref);
apply(accounts, remove, Args, Req, Sender, Ref) ->
  hypermark_example_processes:execute(node_accounts, removeAccount, Args, Req, Sender, Ref);
apply(Module, Fun, Args, _, _, _) ->
  {error, {undef, {Module, Fun, Args}}}.

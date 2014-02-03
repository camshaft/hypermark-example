-module(hypermark_example_index_resource).

-export([init_action/1]).

init_action(_) ->
  {ok, 200, [], <<"it worked!">>}.

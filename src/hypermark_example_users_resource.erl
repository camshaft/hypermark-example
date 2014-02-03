-module(hypermark_example_users_resource).

-export([read_action/1]).
-export([read_transition/1]).

read_action(Req) ->
  %% TODO compile with module
  {ok, AST} = lgx:compile([

    %% Serialize
    {serialize, serializer, execute, [{'$exec', conditions}, {'$exec', accept}]},

    {'scope/relation', '$var', 'commands/users/relation_to'},
    {'scope/account', '$var', 'commands/accounts/get'},

    %% Inputs
    {'input/user', input, user, [required]},

    %% Commands
    {'commands/users/relation_to', command, execute, [users, relation_to, [{'$exec', 'input/user'}, {'$exec', 'provider/auth/owner_id'}]]},
    {'commands/accounts/get', command, execute, [accounts, get, [{'$exec', 'input/user'}, {'$exec', 'provider/env/name'}]]},

    %% Providers
    {'provider/auth/owner_id', provider, get, [auth, owner_id]},
    {'provider/auth/scopes', provider, get, [auth, scopes]},
    {'provider/env/name', provider, get, [env, name]},

    %% Conditions
    {'conditions', '$cond', combine_conditions, authorized, unauthorized},
    {'combine_conditions', bif, 'and', []},

    %% Authorized
    {authorized, bif, args, [{href, {'$exec', href}}, {properties, {'$exec', properties}}, {transitions, {'$exec', transitions}}]},

    %% Unauthorized
    {unauthorized, bif, args, [{href, {'$exec', href}}, {error, [{mesage, unauthorized}]}]},

    %% Protocol
    {href, protocol, get, [href]},
    {accept, protocol, get, [accept]},

    %% Properties
    {properties, bif, filter, [
      {<<"name">>, {'$exec', property_name}},
      {<<"email">>, {'$exec', property_email}},
      {<<"birthday">>, {'$exec', property_birthday}}]},

      %% name
      {property_name, '$cond', property_name_conditions, property_name_value},
        {property_name_conditions, bif, 'and', [{'$exec', property_name_conditions_1}]},
          {property_name_conditions_1, bif, 'in', [<<"account.read.name">>, {'$exec', 'provider/auth/scopes'}]},
      {property_name_value, bif, get, [<<"name">>, {'$exec', 'scope/account'}]},

      %% email
      {property_email, '$cond', property_email_conditions, property_email_value},
        {property_email_conditions, bif, 'and', [{'$exec', property_email_conditions_1}]},
          {property_email_conditions_1, bif, 'in', [<<"account.read.email">>, {'$exec', 'provider/auth/scopes'}]},
      {property_email_value, bif, get, [<<"email">>, {'$exec', 'scope/account'}]},

      %% birthday
      {property_birthday, '$cond', property_birthday_conditions, property_birthday_value},
        {property_birthday_conditions, bif, 'and', [{'$exec', property_birthday_conditions_1}]},
          {property_birthday_conditions_1, bif, 'in', [<<"account.read.birthday">>, {'$exec', 'provider/auth/scopes'}]},
      {property_birthday_value, bif, get, [<<"birthday">>, {'$exec', 'scope/account'}]},

    %% Transitions
    {transitions, bif, filter, [
      {<<"followers">>, {'$exec', transition_followers}},
      {<<"following">>, {'$exec', transition_following}},
      {<<"update">>, {'$exec', transition_update}}]},

      %% followers
      {transition_followers, transition, get, [followers, list_transition, [{user, {'$exec', 'input/user'}}]], spawn},

      %% following
      {transition_following, transition, get, [following, list_transition, [{user, {'$exec', 'input/user'}}]], spawn},

      %% update
      {transition_update, transition, get, [users, update_transition, [{name, {'$exec', property_name}},
                                                            {email, {'$exec', property_email}}]], spawn}

  ], serialize),

  %% TODO get the status code and headers
  case lgx:execute(AST, fun hypermark_req:execute/6, Req) of
    {ok, Result} ->
      {ok, 200, [], Result};
    {error, Error} ->
      {error, 500, [], io_lib:format("~p" ,[Error])}
  end.

read_transition(Req) ->
  %% TODO compile with module
  {ok, AST} = lgx:compile([
    {render, bif, args, [{href, {'$exec', href}}]},

    {href, protocol, href, []}
  ], render),
  lgx:execute(AST, fun hypermark_req:execute/6, Req).

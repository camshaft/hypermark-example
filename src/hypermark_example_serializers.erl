-module(hypermark_example_serializers).

-export([types/0]).
-export([serialize/2]).
-export([serialize/3]).

types() ->
  [
    <<"application/hyper+json">>,
    <<"application/json">>,
    <<"application/hyper+protobuf">>,
    <<"application/collection+json">>,
    <<"application/hal+json">>
  ].

serialize(Type, Resource) ->
  serialize(Type, Resource, []).

serialize(<<"application/hyper+json">>, Resource, Opts) ->
  hypermark_hyperjson_serializer:serialize(Resource, Opts);
serialize(<<"application/json">>, Resource, Opts) ->
  hypermark_hyperjson_serializer:serialize(Resource, Opts);
serialize(<<"application/hyper+protobuf">>, Resource, Opts) ->
  hypermark_hyperproto_serializer:serialize(Resource, Opts);
serialize(<<"application/collection+json">>, Resource, Opts) ->
  hypermark_collectionjson_serializer:serialize(Resource, Opts);
serialize(<<"application/hal+json">>, Resource, Opts) ->
  hypermark_haljson_serializer:serialize(Resource, Opts);
serialize(Type, Resource, Opts) ->
  erlang:error(unsupported_type, [Type, Resource, Opts]).

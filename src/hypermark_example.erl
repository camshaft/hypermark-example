-module(hypermark_example).

start() ->
  ensure:started(hypermark),

  %% ensure the protocols are started
  ensure:started(hypermark_cowboy_http),
  ensure:started(hypermark_cowboy_ws),

  ensure:started(hypermark_example).

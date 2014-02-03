PROJECT = hypermark_example

# Dependencies

PKG_FILE_URL = https://gist.github.com/camshaft/815c139ad3c1ccf13bad/raw/packages.tsv

DEPS = hypermark_cowboy_protocol hypermark_hyperjson_serializer simple_sup sync

# dep_hypermark = pkg://hypermark master
dep_hypermark_cowboy_protocol = pkg://hypermark_cowboy_protocol master
dep_hypermark_hyperjson_serializer = pkg://hypermark_hyperjson_serializer master
# dep_hypermark_collectionjson_serializer = pkg://hypermark_collectionjson_serializer master
# dep_hypermark_haljson_serializer = pkg://hypermark_haljson_serializer master

# temporary
dep_simple_sup = pkg://simple_sup master
dep_sync = pkg://sync master

include erlang.mk

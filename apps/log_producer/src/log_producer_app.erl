-module(log_producer_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

-spec start(term(), term()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
    log_producer_sup:start_link().

-spec stop(term()) -> ok.
stop(_State) ->
    ok.

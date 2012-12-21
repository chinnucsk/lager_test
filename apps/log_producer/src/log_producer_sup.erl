
-module(log_producer_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(Mod, Timeout), {make_id(Mod, Timeout), {Mod, start_link, [Timeout]}, permanent, 5000, worker, [Mod]}).

%% ===================================================================
%% API functions
%% ===================================================================

-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

-spec init([]) -> {ok, {{supervisor:strategy(), integer(), integer()}, [supervisor:child_spec()]}}.
init([]) ->
    {ok, { {one_for_one, 5, 10}, [
					?CHILD(log_producer_wrk, I * 10) || I <- lists:seq(0, 10)
				]} }.

make_id(Mod, Timeout) ->
	list_to_atom(lists:flatten(io_lib:format("~p-~p", [Mod, Timeout]))).

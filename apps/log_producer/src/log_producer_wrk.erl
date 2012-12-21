-module(log_producer_wrk).
-behaviour(gen_server).

-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/1]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

-spec start_link(Timeout :: integer()) -> {ok, pid()}.
start_link(Timeout) when is_integer(Timeout) ->
	gen_server:start_link({local, list_to_atom(lists:flatten(io_lib:format("~p-~p", [?SERVER, Timeout])))}, ?MODULE, Timeout, []).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

-spec init(Timeout :: integer()) -> {ok, Timeout :: integer(), Timeout :: integer()}.
init(Timeout) ->
    {ok, Timeout, Timeout}.

-spec handle_call(term(), term(), Timeout :: integer()) -> {noreply, Timeout :: integer()}.
handle_call(_Request, _From, Timeout) ->
    {noreply, Timeout}.

-spec handle_cast(term(), Timeout :: integer()) -> {noreply, Timeout :: integer()}.
handle_cast(_Msg, Timeout) ->
    {noreply, Timeout}.

-spec handle_info(timeout | term(), Timeout :: integer()) -> {noreply, Timeout :: integer()} | {noreply, Timeout :: integer(), Timeout :: integer()}.
handle_info(timeout, Timeout) ->
	lager:debug("debug message with timeout: ~p", [Timeout]),
	lager:info("info message with timeout: ~p", [Timeout]),
	lager:notice("notice message with timeout: ~p", [Timeout]),
	lager:warning("warning message with timeout: ~p", [Timeout]),
	lager:error("error message with timeout: ~p", [Timeout]),
	lager:critical("critical message with timeout: ~p", [Timeout]),
	lager:alert("alert message with timeout: ~p", [Timeout]),
	lager:emergency("emergency message with timeout: ~p", [Timeout]),
	{noreply, Timeout, Timeout};
handle_info(_Info, Timeout) ->
    {noreply, Timeout}.

-spec terminate(term(), term()) -> ok.
terminate(_Reason, _State) ->
    ok.

-spec code_change(term(), Timeout :: integer(), term()) -> {ok, Timeout :: integer()}.
code_change(_OldVsn, Timeout, _Extra) ->
    {ok, Timeout}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------


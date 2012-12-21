-module (log_producer_starter).

-export([
	start/1,
	stop/1,
	start/0,
	stop/0
	]).


-spec start() -> ok | no_return().
start() ->
	start(log_producer).

-spec stop() -> ok | no_return().
stop() ->
	stop(log_producer).

ensure_app_started(App) ->
	case application:start(App) of
		ok -> ok;
		{error, {already_started, App}} -> ok
	end.

ensure_app_loaded(App) ->
	case application:load(App) of
		ok -> ok;
		{error, {already_loaded, App}} -> ok
	end.

app_deps(App) ->
	{ok, Deps} = application:get_key(App, applications),
	Deps.

start_deps(App) ->
	lists:foreach(fun(Dep) -> start(Dep) end, app_deps(App)).

stop_deps(App) ->
	lists:foreach(fun(Dep) -> stop(Dep) end, lists:reverse(app_deps(App))).


-spec start(atom()) -> ok | no_return().
start(App) ->
	ok = ensure_app_loaded(App),
	start_deps(App),
	ok = ensure_app_started(App).

-spec stop(atom()) -> ok | no_return().
stop(App) ->
	ok = application:stop(App),
	stop_deps(App).


REBAR=./rebar

.PHONY: deps

all: build rel run


build: deps
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps


rel: rel-server rel-client


rel-server:


rel-client:


run: run-server run-client


run-server:
	erl -sname lagger_test -pa apps/*/ebin -pa deps/*/ebin -config debug/lager.config -s log_producer_starter


run-client:



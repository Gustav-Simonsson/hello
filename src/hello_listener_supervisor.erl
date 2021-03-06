% Copyright (c) 2010-2011 by Travelping GmbH <info@travelping.com>

% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the "Software"),
% to deal in the Software without restriction, including without limitation
% the rights to use, copy, modify, merge, publish, distribute, sublicense,
% and/or sell copies of the Software, and to permit persons to whom the
% Software is furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
% DEALINGS IN THE SOFTWARE.

% @private
-module(hello_listener_supervisor).
-behaviour(supervisor).
-export([start_link/0, start_child/1, stop_child/1]).
-export([init/1]).

-define(SERVER, hello_listener_supervisor).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, {}).

start_child(ChildSpec) ->
    supervisor:start_child(?SERVER, ChildSpec).

stop_child(ID) ->
    case supervisor:terminate_child(?SERVER, ID) of
        ok ->
            supervisor:delete_child(?SERVER, ID);
        {error, not_found} ->
            {error, not_found}
    end.

init({}) ->
    Children = [],
    RestartStrategy = {one_for_one, 5, 10},
    {ok, {RestartStrategy, Children}}.

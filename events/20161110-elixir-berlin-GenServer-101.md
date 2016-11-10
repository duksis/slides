# GenServer 101
## Introduction to GenServers
### by Hugo Duksis

---

## Topics

* Technical (implementation) details
* Use cases

Note:

Usually you start with a problem and work
towards a solution. This time I'll do it
the other way around. By first, on a very high
level, explaining what GenServer is and how it
looks inside Elixir. And than continue on with
what kind of problems it can be used to solve.

So... today I want to cover the following topics ..

---

## Technical (implementation) details

* What is GenServer
* Usage


---

## What is GenServer?

* Open Telecom Platform
* Library
* Module (functions, macros)
* behavior

---

## Usage

```elixir
defmodule TodoList do
  use GenServer
  # require GenServer
  # GenServer.__using__(__MODULE__)
end
```

calls macro `GenServer.__using__/1`

---

## Using is expanding

```elixir
defmodule TodoList do
  @behaviour :gen_server

  def init(args) do ...
  def handle_call(msg, _from, state) do ...
  def handle_info(_msg, state) do ...
  def handle_cast(msg, state) do ...
  def terminate(_reason, _state) do ...
  def code_change(_old, state, _extra) do ...

  defoverridable [init: 1, handle_call: 3, handle_info: 2,
                  handle_cast: 2, terminate: 2, code_change: 3]
end
```

---

## `GenServer` and `:gen_server`

* `:"Elixir.GenServer"`
* `:gen_server`

---

## `:"Elixir.GenServer"`

* Injects predefined functions for the `:gen_server` api
* Improves usability by providing defaults (`GenServer.start/3` vs `:gen.start/6`)

---

## `:gen_server`

* Behavoir - requiring modules to implement the GenServer interface

---

## Creating a gen server module

```
defmodule TodoList do
  use GenServer

  # Client API

  # Server API
end
```

---

## Client API

```
defmodule TodoList do
  use GenServer

  # Client API
  def start do
    {:ok, todo_list} = GenServer.start(__MODULE__, [])
    todo_list
  end

  def add_task(todo_list, task) when is_binary(task) do
    GenServer.cast(todo_list, {:add, task})
  end

  def list_tasks(todo_list) do
    GenServer.call(todo_list, {:list})
  end

  # Server API
  # ...
end
```

---

## Server API

```
defmodule TodoList do
  use GenServer
  # Client API
  # ...

  # Server API
  def handle_cast({:add, task}, tasks) do
    {:noreply, [task | tasks]}
  end

  def handle_call({:list}, _from, tasks) do
    {:reply, tasks, tasks}
  end
end
```

---

## Execution flow

```
TodoList.add_task ->
  GenServer.call ->
    :gen.call ->
      TodoList.handle_call
```

---

## Use cases

* Why do we need GenServer?
* What are our other options?
* Examples

---

## Why? - State

Main options for state

  * Processes
  * ETS (Erlang Term Storage)

---

## State in Processes

* Agent
* GenServer
* GenEvent
* Task

note:

We rarely hand-roll our own, instead we use the
abstractions available in Elixir and OTP

---

## Agent vs GenServer

* Agent
  - Simple wrappers around state.

* GenServer
  - "Generic servers" (processes) that encapsulate state,
  - provide sync and async calls,
  - support code reloading,
  - and more.

---

## Example

`events/20161110-elixir-berlin-GenServer-101/GenServer_example.ex`

---

## Summary

* GenServer is just a module :) (don't be scared of it)
* Chose it when you have to deal with state, sync and async

---

## Sources and additional reading

* [Elixir guides][2]
* [Elixir Documentation][3]
* [Stevan Leiva's blog post][1]

---

## Q&A

---

## The END


[1]: https://medium.com/@StevenLeiva1/understanding-elixir-s-genserver-a8d5756e6848#.flji1c6of
[2]: http://elixir-lang.org/getting-started/mix-otp/genserver.html
[3]: http://elixir-lang.org/docs/stable/elixir/GenServer.html
[4]: http://culttt.com/2016/08/24/understanding-genserver-elixir/
[5]: https://blog.drewolson.org/understanding-gen-server/

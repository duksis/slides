## Building an API client library
### by Hugo Duksis

---

## Why?

* We need it
* It is easy **

** but there is always a but

---

## We need it

* We know that Elixir is amazing for building:
  * Fault tolerant
  * Distributed
  * Massively scalable applications

* But what if you don't really feel the need for such applications? (yet)
  * you still most likely have plenty of problems that could be solved with Elixir
  * and some of them might require to communicate with a 3rd party API

Note:

Or might just want to contribute to the Ecosystem

---

## It is easy!!.?

* Deciding how you want the interface to look like
  * Search for inspiration and use what you like most
* Http client library
  * HTTPoison (hackney)
  * HTTPotion (ibrowse)
* decode API responses
  * poison
  * exjsx
  * json
* Authentication
  * basic auth
  * Oauth2
  * Oauth

---

## Lets create one now

https://docs.travis-ci.com/api

* new mix project
`mix new travis_ex`

* update the README with what you want to achieve

```iex
iex> client = TravisEx.Client.new(auth: "bb1568179c33308f4da7dceab")
iex> %{"repo" => %{"last_build_state" => build_state}} = TravisEx.Repos.get "duksis/travis_ex", client
iex> build_state #=> "passed"
```


## Add dependencies

```elixir
  ## mix.exs
  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison, "~> 1.5"},
      {:exvcr, "~> 0.7", only: :test},
      {:excoveralls, "~> 0.4", only: :test}
    ]
  end
```

## Lets start with a simple client

```elixir
defmodule TravisEx.Client do
  defstruct headers: nil, endpoint: "https://api.travis-ci.org/"

  @user_agent [{"User-agent", "travis_ex"}]
  @accept [{"Accept", "application/vnd.travis-ci.2+json"}]

  @type t :: %__MODULE__{headers: list, endpoint: binary}

  @spec new(map) :: t
  def new(auth: auth) do
    %__MODULE__{ headers: @user_agent ++ @accept ++ [{"Authorization", "token #{auth}"}] }
  end
end
```

## And move on to actually working with an API entity

```elixir
defmodule TravisEx.Repos do
  use HTTPoison.Base

  @doc """
  Fetch repository
    https://docs.travis-ci.com/api#repositories
  """

  @spec get(binary, TravisEx.Client.t) :: map
  def get(slug, client) do
    _get("repos/#{slug}", client)
  end

  defp _get(path, client, options \\ []) do
    request!(:get, client.endpoint <> path, "", client.headers, options)
    |> process_response
  end

  defp process_response(response) do
    response.body |> Poison.decode!
  end
end
```

## Add package info

```elixir
  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Hugo Duksis"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/duksis/travis_ex"}
    ]
  end
```

push it to hex:

```console
mix hex.publish
```

and we have a working client library covering one endpoint

Note:

Options
  * Heroku scale api
  * Bitbucket

---


## The END

defmodule Todolix.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/realtime"

  get "/", Todolix.PageController, :index, as: :pages
  resources "/todos", Todolix.TodoController
  channel "todo", Todolix.TodoChannel

end

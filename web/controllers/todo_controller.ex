defmodule Todolix.TodoController do
  use Phoenix.Controller
  alias Todolix.Router
  @todolist_name :todo_list
  def index(conn, _params) do
    todos = Todolix.Todolist.get(@todolist_name) |> Enum.reverse
    json conn, JSON.encode!(todos)
  end
  


end

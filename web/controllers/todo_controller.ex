defmodule Todolix.TodoController do
  use Phoenix.Controller
  alias Todolix.Router
  #Global identifier for todolist PID
  @todolist_name :todo_list

  def index(conn, _params) do
    #returns the index in reverse because we add them to the 'front' end of list. 
    todos = Todolix.Todolist.get(@todolist_name) |> Enum.reverse
    json conn, JSON.encode!(todos)
  end

end

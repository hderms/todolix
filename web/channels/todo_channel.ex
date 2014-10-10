defmodule Todolix.TodoChannel do
  use Phoenix.Channel
  #global identifier for the todolist PID
  @todolist_name :todo_list

  def join(socket, "new", message) do
    {:ok, socket}
  end
  def join(socket, "deleted", message) do
    {:ok, socket}
  end
  def join(socket, _no, _message) do
    IO.puts("Unauthorized connection")
    {:error, socket, :unauthorized}
  end

  def event(socket, "new", %{body: ""}) do
    #Don't try to do anything if body is empty.  
    #Returning an error wasn't deemed necessary
    socket
  end
  def event(socket, "new",  params) do
    #We will create a todo struct and then
    #broadcast down the appropriate channel
    new_todo = create(socket, params)
    broadcast("todo", "new", "new",  new_todo)
    socket
  end
  def event(socket, "remove", %{"uuid" => ""}) do
    socket
  end
  def event(socket, "remove",  %{"uuid" => uuid} = params) do
    success = delete(uuid)
    broadcast("todo", "deleted", "deleted",  %{uuid: uuid})
    socket
  end
  def event(socket, topic, message) do
    #Safely ignore any event for which we don't care about the topic
    socket
  end

  def create(_, %{"body" => ""}) do
    raise ArgumentError, message: "Todo Channel can't create todo with an empty body"
  end
  def create(conn,   %{"body" => body} = params) do
    Todolix.Todolist.create_and_insert(@todolist_name, body)
  end

  defp delete("") do
    raise ArgumentError, message: "Todo Channel can't delete todo by an empty UUID"
  end
  defp delete(uuid) do
    Todolix.Todolist.delete(@todolist_name, uuid)
  end

end

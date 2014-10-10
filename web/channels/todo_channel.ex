defmodule Todolix.TodoChannel do
  use Phoenix.Channel

  @todolist_name :todo_list
  def join(socket, "new", message) do
    {:ok, socket}
  end
  def join(socket, _no, _message) do
    IO.puts("Unauthorized connection")
    {:error, socket, :unauthorized}
  end

  def event(_, "new", %{body: ""}) do
    IO.puts("empty body");
  end
  def event(socket, "new",  params) do
    new_todo = create(socket, params)
    IO.puts(inspect(params))
    broadcast("todo", "new", "new",  new_todo)
    socket
  end
  def event(socket, "delete",  %{"uuid" => uuid} = params) do
    success = delete(uuid)
    IO.puts(inspect(params))
    broadcast("todo", "delete", "delete",  uuid)
    socket
  end

  def event(socket, topic, message) do
    IO.puts("Massive failure")
    IO.puts(topic)
    socket
end

  def create(conn,   %{"body" => body} = params) do
    IO.puts(body)
    Todolix.Todolist.create_and_insert(@todolist_name, body)
  end

  defp delete(uuid) do
    Todolix.Todolist.delete(uuid)
  end

end

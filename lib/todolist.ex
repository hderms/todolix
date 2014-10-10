defmodule Todolix.Todo do
  defstruct body: "Sample todo...", uuid: ""
end

defmodule Todolix.Todolist do
  alias Todolix.Todo
  def start_link(opts \\ []) do
    Agent.start_link(fn -> [] end, opts)
  end
  def get(agent) do
    Agent.get(agent, fn list -> list end)
  end
  def push(agent, element) do
    Agent.update(agent, fn list -> [element | list] end)
  end
  def create_and_insert(agent, body) when is_bitstring(body) do
    new_todo = body |> create;
    push(agent, new_todo)
    new_todo
  end
  def delete(agent, uuid) do
    Agent.update(agent, 
                      fn list -> 
                        bad_element_index = Enum.find_index(list, &(&1.uuid == uuid))
                        List.delete_at(list, bad_element_index)
                      end)
  end

  defp create("") do
    raise ArgumentError, message: "Can't create a todo with an empty body"
  end
  defp create(element) when is_bitstring(element) do
    %Todo{body: element, uuid: UUID.uuid1()}
  end
end


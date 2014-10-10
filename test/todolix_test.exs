defmodule TodolixTest do
  use ExUnit.Case
  alias Todolix.Todolist
  setup do 
      {:ok, agent} = Todolix.Todolist.start_link()
      {:ok, agent: agent}

  end
  test "Todolist should be empty by default",  context  do
    agent = context.agent
    assert Todolist.get(agent) == []
  end
  test "Todolist should retain a single element",  context  do
    agent = context.agent
    Todolist.push(agent, "Something")
    assert Todolist.get(agent) == ["Something"]
  end
  test "Todolist should retain multiple elements",  context  do
    agent = context.agent
    Todolist.push(agent, "bar")
    Todolist.push(agent, "foo")
    assert Todolist.get(agent) == ["foo", "bar"]
  end
  test "Todolist should allow creation of a todo",  context  do
    agent = context.agent
    Todolist.create_and_insert(agent, "bar")
    first_element = Todolist.get(agent) |> List.first
    assert first_element.body == "bar"
  end
  test "Todolist should create todos with a uuid",  context  do
    agent = context.agent
    Todolist.create_and_insert(agent, "bar")
    first_element = Todolist.get(agent) |> List.first
    assert first_element.uuid != ""


  end
  test "Todolist should allow removal of todo by uuid ",  context  do
    agent = context.agent
    Todolist.create_and_insert(agent, "bar")
    first_element = Todolist.get(agent) |> List.first
    uuid = first_element.uuid
    Todolist.delete(agent, uuid)
    list_post_removal = Todolist.get(agent)
    assert list_post_removal == []
  end
end

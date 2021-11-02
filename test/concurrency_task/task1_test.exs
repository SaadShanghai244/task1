defmodule ConcurrencyTask.Task1Test do
  use ConcurrencyTask.DataCase

  alias ConcurrencyTask.Task1

  describe "queue" do
    alias ConcurrencyTask.Task1.Queue

    import ConcurrencyTask.Task1Fixtures

    @invalid_attrs %{status: nil}

    test "list_queue/0 returns all queue" do
      queue = queue_fixture()
      assert Task1.list_queue() == [queue]
    end

    test "get_queue!/1 returns the queue with given id" do
      queue = queue_fixture()
      assert Task1.get_queue!(queue.id) == queue
    end

    test "create_queue/1 with valid data creates a queue" do
      valid_attrs = %{status: "some status"}

      assert {:ok, %Queue{} = queue} = Task1.create_queue(valid_attrs)
      assert queue.status == "some status"
    end

    test "create_queue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task1.create_queue(@invalid_attrs)
    end

    test "update_queue/2 with valid data updates the queue" do
      queue = queue_fixture()
      update_attrs = %{status: "some updated status"}

      assert {:ok, %Queue{} = queue} = Task1.update_queue(queue, update_attrs)
      assert queue.status == "some updated status"
    end

    test "update_queue/2 with invalid data returns error changeset" do
      queue = queue_fixture()
      assert {:error, %Ecto.Changeset{}} = Task1.update_queue(queue, @invalid_attrs)
      assert queue == Task1.get_queue!(queue.id)
    end

    test "delete_queue/1 deletes the queue" do
      queue = queue_fixture()
      assert {:ok, %Queue{}} = Task1.delete_queue(queue)
      assert_raise Ecto.NoResultsError, fn -> Task1.get_queue!(queue.id) end
    end

    test "change_queue/1 returns a queue changeset" do
      queue = queue_fixture()
      assert %Ecto.Changeset{} = Task1.change_queue(queue)
    end
  end
end

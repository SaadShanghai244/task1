defmodule ConcurrencyTaskWeb.QueueControllerTest do
  use ConcurrencyTaskWeb.ConnCase

  import ConcurrencyTask.Task1Fixtures

  @create_attrs %{status: "some status"}
  @update_attrs %{status: "some updated status"}
  @invalid_attrs %{status: nil}

  describe "index" do
    test "lists all queue", %{conn: conn} do
      conn = get(conn, Routes.queue_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Queue"
    end
  end

  describe "new queue" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.queue_path(conn, :new))
      assert html_response(conn, 200) =~ "New Queue"
    end
  end

  describe "create queue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.queue_path(conn, :create), queue: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.queue_path(conn, :show, id)

      conn = get(conn, Routes.queue_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Queue"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.queue_path(conn, :create), queue: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Queue"
    end
  end

  describe "edit queue" do
    setup [:create_queue]

    test "renders form for editing chosen queue", %{conn: conn, queue: queue} do
      conn = get(conn, Routes.queue_path(conn, :edit, queue))
      assert html_response(conn, 200) =~ "Edit Queue"
    end
  end

  describe "update queue" do
    setup [:create_queue]

    test "redirects when data is valid", %{conn: conn, queue: queue} do
      conn = put(conn, Routes.queue_path(conn, :update, queue), queue: @update_attrs)
      assert redirected_to(conn) == Routes.queue_path(conn, :show, queue)

      conn = get(conn, Routes.queue_path(conn, :show, queue))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, queue: queue} do
      conn = put(conn, Routes.queue_path(conn, :update, queue), queue: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Queue"
    end
  end

  describe "delete queue" do
    setup [:create_queue]

    test "deletes chosen queue", %{conn: conn, queue: queue} do
      conn = delete(conn, Routes.queue_path(conn, :delete, queue))
      assert redirected_to(conn) == Routes.queue_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.queue_path(conn, :show, queue))
      end
    end
  end

  defp create_queue(_) do
    queue = queue_fixture()
    %{queue: queue}
  end
end

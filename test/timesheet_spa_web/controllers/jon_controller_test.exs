defmodule TimesheetSpaWeb.JonControllerTest do
  use TimesheetSpaWeb.ConnCase

  alias TimesheetSpa.Jobs
  alias TimesheetSpa.Jobs.Jon

  @create_attrs %{
    code: "some code",
    description: "some description",
    hours: 42,
    name: "some name"
  }
  @update_attrs %{
    code: "some updated code",
    description: "some updated description",
    hours: 43,
    name: "some updated name"
  }
  @invalid_attrs %{code: nil, description: nil, hours: nil, name: nil}

  def fixture(:jon) do
    {:ok, jon} = Jobs.create_jon(@create_attrs)
    jon
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all jobs", %{conn: conn} do
      conn = get(conn, Routes.jon_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create jon" do
    test "renders jon when data is valid", %{conn: conn} do
      conn = post(conn, Routes.jon_path(conn, :create), jon: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.jon_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => "some code",
               "description" => "some description",
               "hours" => 42,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.jon_path(conn, :create), jon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update jon" do
    setup [:create_jon]

    test "renders jon when data is valid", %{conn: conn, jon: %Jon{id: id} = jon} do
      conn = put(conn, Routes.jon_path(conn, :update, jon), jon: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.jon_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => "some updated code",
               "description" => "some updated description",
               "hours" => 43,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, jon: jon} do
      conn = put(conn, Routes.jon_path(conn, :update, jon), jon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete jon" do
    setup [:create_jon]

    test "deletes chosen jon", %{conn: conn, jon: jon} do
      conn = delete(conn, Routes.jon_path(conn, :delete, jon))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.jon_path(conn, :show, jon))
      end
    end
  end

  defp create_jon(_) do
    jon = fixture(:jon)
    {:ok, jon: jon}
  end
end

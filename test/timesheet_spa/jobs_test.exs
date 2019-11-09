defmodule TimesheetSpa.JobsTest do
  use TimesheetSpa.DataCase

  alias TimesheetSpa.Jobs

  describe "jobs" do
    alias TimesheetSpa.Jobs.Jon

    @valid_attrs %{code: "some code", description: "some description", hours: 42, name: "some name"}
    @update_attrs %{code: "some updated code", description: "some updated description", hours: 43, name: "some updated name"}
    @invalid_attrs %{code: nil, description: nil, hours: nil, name: nil}

    def jon_fixture(attrs \\ %{}) do
      {:ok, jon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_jon()

      jon
    end

    test "list_jobs/0 returns all jobs" do
      jon = jon_fixture()
      assert Jobs.list_jobs() == [jon]
    end

    test "get_jon!/1 returns the jon with given id" do
      jon = jon_fixture()
      assert Jobs.get_jon!(jon.id) == jon
    end

    test "create_jon/1 with valid data creates a jon" do
      assert {:ok, %Jon{} = jon} = Jobs.create_jon(@valid_attrs)
      assert jon.code == "some code"
      assert jon.description == "some description"
      assert jon.hours == 42
      assert jon.name == "some name"
    end

    test "create_jon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_jon(@invalid_attrs)
    end

    test "update_jon/2 with valid data updates the jon" do
      jon = jon_fixture()
      assert {:ok, %Jon{} = jon} = Jobs.update_jon(jon, @update_attrs)
      assert jon.code == "some updated code"
      assert jon.description == "some updated description"
      assert jon.hours == 43
      assert jon.name == "some updated name"
    end

    test "update_jon/2 with invalid data returns error changeset" do
      jon = jon_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_jon(jon, @invalid_attrs)
      assert jon == Jobs.get_jon!(jon.id)
    end

    test "delete_jon/1 deletes the jon" do
      jon = jon_fixture()
      assert {:ok, %Jon{}} = Jobs.delete_jon(jon)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_jon!(jon.id) end
    end

    test "change_jon/1 returns a jon changeset" do
      jon = jon_fixture()
      assert %Ecto.Changeset{} = Jobs.change_jon(jon)
    end
  end

  describe "jobs" do
    alias TimesheetSpa.Jobs.Job

    @valid_attrs %{code: "some code", description: "some description", hours: 42, name: "some name"}
    @update_attrs %{code: "some updated code", description: "some updated description", hours: 43, name: "some updated name"}
    @invalid_attrs %{code: nil, description: nil, hours: nil, name: nil}

    def job_fixture(attrs \\ %{}) do
      {:ok, job} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_job()

      job
    end

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Jobs.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Jobs.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      assert {:ok, %Job{} = job} = Jobs.create_job(@valid_attrs)
      assert job.code == "some code"
      assert job.description == "some description"
      assert job.hours == 42
      assert job.name == "some name"
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      assert {:ok, %Job{} = job} = Jobs.update_job(job, @update_attrs)
      assert job.code == "some updated code"
      assert job.description == "some updated description"
      assert job.hours == 43
      assert job.name == "some updated name"
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(job, @invalid_attrs)
      assert job == Jobs.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Jobs.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Jobs.change_job(job)
    end
  end
end

defmodule Topics.UsersTest do
  use Topics.DataCase

  import Topics.Factory

  alias Topics.Users
  alias Topics.Users.User

  @invalid_attrs %{name: nil}

  describe "users.list_users/0" do
    test "returns all users" do
      user = insert!(:user)
      assert Users.list_users() == [user]
    end
  end

  describe "users.get_user!/1" do
    test "get_user!/1 returns the user with given id" do
      user = insert!(:user)
      assert Users.get_user!(user.id) == user
    end
  end

  describe "users.get_user/1" do
    test "returns the user with given id" do
      user = insert!(:user)
      assert Users.get_user(user.id) == user
    end

    test "returns nil if no user is found" do
      assert is_nil(Users.get_user(123))
    end

    test "returns nil if id is nil" do
      assert is_nil(Users.get_user(nil))
    end
  end

  describe "users.create_user/1" do
    test "with valid data creates a user" do
      valid_attrs = %{name: "Alice", username: "123456789"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.name == "Alice"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end
  end

  describe "users.update_user/2" do
    test "with valid data updates the user" do
      user = insert!(:user)
      update_attrs = %{name: "Bob"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.name == "Bob"
    end

    test "with invalid data returns error changeset" do
      user = insert!(:user)
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end
  end

  describe "users.delete_user/1" do
    test "deletes the user" do
      user = insert!(:user)
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end
  end

  describe "users.change_user/1 " do
    test "returns a user changeset" do
      user = insert!(:user)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  describe "users.login/1 " do
    test "if authentication passes for a new user creates a user record" do
      {:ok, user} = Users.login("admin", "Secret123")
      assert %User{username: "admin", name: "Administrator"} = user
      assert [user] == Users.list_users()
    end

    test "if authentication passes for an existing user updates the name" do
      insert!(:user, username: "admin", name: "Old Name")
      {:ok, user} = Users.login("admin", "Secret123")
      assert %User{username: "admin", name: "Administrator"} = user
      assert [user] == Users.list_users()
    end
  end
end

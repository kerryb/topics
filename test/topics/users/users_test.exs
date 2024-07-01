defmodule Topics.UsersTest do
  use Topics.DataCase

  alias Topics.Users

  describe "users" do
    alias Topics.Users.User

    @invalid_attrs %{name: nil}

    test "list_users/0 returns all users" do
      user = insert!(:user)
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert!(:user)
      assert Users.get_user!(user.id) == user
    end

    test "get_user/1 returns the user with given id" do
      user = insert!(:user)
      assert Users.get_user(user.id) == user
    end

    test "get_user/1 returns nil if no user is found" do
      assert is_nil(Users.get_user(123))
    end

    test "get_user/1 returns nil if id is nil" do
      assert is_nil(Users.get_user(nil))
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "Alice", username: "123456789"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.name == "Alice"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert!(:user)
      update_attrs = %{name: "Bob"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.name == "Bob"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert!(:user)
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert!(:user)
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert!(:user)
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end

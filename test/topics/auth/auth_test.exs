defmodule Topics.Users.AuthTest do
  @moduledoc """
  Tests use [Online LDAP Test
  Server](https://www.forumsys.com/2022/05/10/online-ldap-test-server/).
  """
  use Topics.DataCase, async: true

  alias Topics.Users.Auth

  test "returns true if LDAP bind succeeds" do
    assert Auth.validate("employee", "Secret123")
  end

  test "returns false if LDAP bind fails" do
    refute Auth.validate("employee", "wrong")
  end
end

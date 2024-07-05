defmodule Topics.Users.LDAPTest do
  @moduledoc """
  Tests for ldap authentication. The `test` environment is configured to
  connect to the [FreeIPA demo server](https://www.freeipa.org/page/Demo)
  rather than the real BT server.
  """
  use Topics.DataCase, async: true

  alias Topics.Users.LDAP

  test "returns {:ok, name} if LDAP bind succeeds" do
    assert LDAP.validate("admin", "Secret123") == {:ok, "Administrator"}
  end

  test "returns {:error, reason} if LDAP bind fails" do
    assert LDAP.validate("admin", "wrong") == {:error, :invalidCredentials}
  end
end

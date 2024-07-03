defmodule Topics.Users.LDAPTest do
  @moduledoc """
  Tests for ldap authentication. The `test` environment is configured to
  connect to the [FreeIPA demo server](https://www.freeipa.org/page/Demo)
  rather than the real BT server.
  """
  use Topics.DataCase, async: true

  alias Topics.Users.LDAP

  test "returns true if LDAP bind succeeds" do
    assert LDAP.validate("employee", "Secret123")
  end

  test "returns false if LDAP bind fails" do
    refute LDAP.validate("employee", "wrong")
  end
end

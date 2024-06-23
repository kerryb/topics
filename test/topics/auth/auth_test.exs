defmodule Topics.Users.AuthTest do
  @moduledoc """
  Tests for ldap authentication. The `test` environment is configured to
  connect to the [FreeIPA demo server](https://www.freeipa.org/page/Demo)
  rather than the real BT server.
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

defmodule Topics.Users.LDAP do
  @moduledoc """
  Authenticates a user against LDAP.
  """

  @config Application.compile_env(:topics, :ldap)
  @host Keyword.fetch!(@config, :host)
  @port Keyword.fetch!(@config, :port)
  @bind_dn_pattern Keyword.fetch!(@config, :bind_dn_pattern)
  @use_ssl Keyword.fetch!(@config, :use_ssl)

  def validate(username, password) do
    {:ok, conn} = Exldap.open(@host, @port, @use_ssl, :timer.seconds(5))
    bind_dn = @bind_dn_pattern |> :io_lib.format([username]) |> to_string()
    match?(:ok, Exldap.verify_credentials(conn, bind_dn, password))
  end
end

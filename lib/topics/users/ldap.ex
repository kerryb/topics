defmodule Topics.Users.LDAP do
  @moduledoc """
  Authenticates a user against LDAP.
  """

  @config Application.compile_env(:topics, :ldap)
  @host Keyword.fetch!(@config, :host)
  @port Keyword.fetch!(@config, :port)
  @username_field Keyword.fetch!(@config, :username_field)
  @base_dn Keyword.fetch!(@config, :base_dn)
  @use_ssl Keyword.fetch!(@config, :use_ssl)

  def validate(username, password) do
    {:ok, conn} = Exldap.open(@host, @port, @use_ssl)
    bind_dn = "#{@username_field}=#{username},#{@base_dn}"

    case Exldap.verify_credentials(conn, bind_dn, password) do
      :ok -> {:ok, get_name(conn, username)}
      error -> error
    end
  end

  defp get_name(conn, username) do
    {:ok, [record]} = Exldap.search_field(conn, @base_dn, @username_field, username)
    Exldap.get_attribute!(record, "gecos")
  end
end

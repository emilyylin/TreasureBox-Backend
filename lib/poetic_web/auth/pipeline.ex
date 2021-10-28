defmodule PoeticWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :poetic,
    module: PoeticWeb.Auth.Guardian,
    error_handler: PoeticWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
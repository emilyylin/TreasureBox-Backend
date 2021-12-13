defmodule PoeticWeb.Router do
  use PoeticWeb, :router
  alias PoeticWeb

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PoeticWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", PoeticWeb do
    pipe_through :browser
    #pipe_through [:browser, :auth]

    resources "/uploads", UploadController, only: [:index, :new, :create, :show]
  end

  scope "/api", PoeticWeb do
    pipe_through :api

    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
    get "/uploads/listUploads", UploadController, :listUploads
    post "/uploads/delete", UploadController, :delete
    post "/uploads/star", UploadController, :star
    post "/uploads/getUpload", UploadController, :getUpload
  end

  pipeline :auth do
    plug PoeticWeb.Auth.Pipeline
  end

  # Other scopes may use custom stacks.
  # scope "/api", PoeticWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PoeticWeb.Telemetry
    end
  end
end

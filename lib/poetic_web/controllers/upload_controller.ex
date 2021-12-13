# lib/poetic_web/controllers/upload_controller.ex

defmodule PoeticWeb.UploadController do
  use PoeticWeb, :controller
  require Logger

  alias Poetic.Documents

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def index(conn, _params) do
    uploads = Documents.list_uploads()
    render(conn, "index.html", uploads: uploads)
  end

  def listUploads(conn, _params) do
    uploads = Documents.list_uploads()
    render(conn, "uploads.json", uploads: uploads)
  end

  def show(conn, %{"id" => id}) do
    upload = Documents.get_upload!(id)
    local_path = Poetic.Documents.Upload.local_path(upload.id, upload.filename)
    send_download conn, {:file, local_path}, filename: upload.filename
  end

  def star(conn, %{"id" => id, "new_value" => new_value}) do
    # Logger.info("#{inspect(id)}")
    upload=Documents.get_upload!(id)
    uploads=Documents.update_upload(upload, %{is_starred: new_value})
    uploads = Documents.list_uploads()
    render(conn, "uploads.json", uploads: uploads)
  end

  def getUpload(conn, %{"id" => id}) do 
    upload=Documents.get_upload!(id)
    render(conn, "upload.json", upload: upload)
  end

  def delete(conn, %{"id" => id, "new_value" => new_value}) do
    # Logger.info("#{inspect(id)}")
    upload=Documents.get_upload!(id)
    uploads=Documents.update_upload(upload, %{"is_deleted": new_value})
    uploads = Documents.list_uploads()
    render(conn, "uploads.json", uploads: uploads)
  end

  def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
    # IO.inspect(upload, label: "UPLOAD")
    # text conn, "ok"

    case Documents.create_upload_from_plug_upload(upload) do

        {:ok, upload}->
        put_flash(conn, :info, "file uploaded correctly")
        redirect(conn, to: Routes.upload_path(conn, :index))

        {:error, reason}->
        put_flash(conn, :error, "error upload file: #{inspect(reason)}")
        render(conn, "new.html")
    end
  end
end
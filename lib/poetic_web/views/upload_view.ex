defmodule PoeticWeb.UploadView do
  use PoeticWeb, :view
  alias PoeticWeb.UploadView

  def render("uploads.json", %{uploads: uploads}) do
    %{uploads: render_many(uploads, UploadView, "upload.json")}
    # %{uploads: uploads}
  end

  # def render("index.json", %{pages: pages}) do
  #   %{data: Enum.map(pages, fn page -> %{title: page.title} end)}
  # end

  def render("upload.json", upload) do
    %{
      id: upload.upload.id,
      filename: upload.upload.filename,
      content_type: upload.upload.content_type,
      inserted_at: upload.upload.inserted_at
    }
  end

end
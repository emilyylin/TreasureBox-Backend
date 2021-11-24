defmodule PoeticWeb.UploadView do
  use PoeticWeb, :view
  use Timex
  alias PoeticWeb.UploadView

  def render("uploads.json", %{uploads: uploads}) do
    %{uploads: render_many(uploads, UploadView, "upload.json")}
  end

  # def render("index.json", %{pages: pages}) do
  #   %{data: Enum.map(pages, fn page -> %{title: page.title} end)}
  # end

  def render("upload.json", upload) do
    d = upload.upload.inserted_at;
    %{
      id: upload.upload.id,
      filename: upload.upload.filename,
      content_type: upload.upload.content_type,
      inserted_at: upload.upload.inserted_at,
      date: Timex.format!(d, "{Mshort} {D}, {YYYY}"),
      time: Timex.format!(d, "{h12}:{m} {AM}"),
      is_starred: upload.upload.is_starred,
      is_deleted: upload.upload.is_deleted,
      recent_access_time: upload.upload.recent_access_time,
      size: upload.upload.size
    }
  end

end
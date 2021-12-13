defmodule Poetic.Documents.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  alias Poetic.Documents

  schema "uploads" do
    field :content_type, :string
    field :filename, :string
    field :hash, :string
    field :size, :integer
    field :is_starred, :boolean
    field :is_deleted, :boolean
    field :recent_access_time, :utc_datetime
    # field :email_body, :string
    # field :email_sender, :string

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:filename, :size, :content_type, :hash, :is_starred, :is_deleted, :recent_access_time])
    |> validate_required([:filename, :size, :content_type, :hash, :is_starred, :is_deleted, :recent_access_time])
    # added validations
    |> validate_number(:size, greater_than: 0) #doesn't allow empty files
    |> validate_length(:hash, is: 64)
  end

  #calculates the SHA-256 hexadecimal digest of the given stream
  #hash of phoenix.png: 07aa9b01595fe10fd4e5ceb6cc67ba186ef8ce91e5a5cba47166f7d8498d7852
  def sha256(chunks_enum) do
    chunks_enum
    |> Enum.reduce(
        :crypto.hash_init(:sha256),
        &(:crypto.hash_update(&2, &1))
    ) 
    |> :crypto.hash_final()
    |> Base.encode16()
    |> String.downcase()
  end

  #function that tells us where to store the file once received
  def upload_directory do
    Application.get_env(:poetic, :uploads_directory)
  end

  def local_path(id, filename) do
    [upload_directory(), "#{id}-#{filename}"]
    |> Path.join()
  end

end

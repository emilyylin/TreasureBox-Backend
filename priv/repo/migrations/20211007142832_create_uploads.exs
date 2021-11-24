defmodule Poetic.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :filename, :string
      add :size, :bigint
      add :hash, :string, size: 64
      add :content_type, :string
      add :is_starred, :boolean
      add :is_deleted, :boolean
      add :recent_access_time, :timestamp

      timestamps()
    end

    create index(:uploads, [:hash])

  end

end

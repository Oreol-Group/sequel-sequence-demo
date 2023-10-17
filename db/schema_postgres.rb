# Version: 20231018010429
Sequel.migration do
  change do
    create_table(:items) do
      primary_key :id
      column :name, 'text'
      column :position, 'bigint', default: Sequel::LiteralString.new("nextval('article'::regclass)")
      column :created_at, 'timestamp with time zone', null: false
      column :updated_at, 'timestamp with time zone', null: false
    end

    create_table(:schema_migrations) do
      column :filename, 'text', null: false

      primary_key [:filename]
    end

    create_table(:things) do
      primary_key :id
      column :name, 'text'
      column :label, 'bigint'
      column :created_at, 'timestamp with time zone', null: false
      column :updated_at, 'timestamp with time zone', null: false
    end
  end
end

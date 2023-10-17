# Version: 20231018013254
Sequel.migration do
  change do
    create_table(:article) do
      primary_key :id
      column :fiction, 'INTEGER'
    end

    create_table(:items) do
      primary_key :id
      column :name, 'TEXT'
      column :position, 'bigint'
      column :created_at, 'timestamp', null: false
      column :updated_at, 'timestamp', null: false
    end

    create_table(:label) do
      primary_key :id
      column :fiction, 'INTEGER'
    end

    create_table(:schema_migrations) do
      column :filename, 'varchar(255)', null: false

      primary_key [:filename]
    end

    create_table(:things) do
      primary_key :id
      column :name, 'varchar(255)'
      column :label, 'bigint'
      column :created_at, 'timestamp', null: false
      column :updated_at, 'timestamp', null: false
    end
  end
end

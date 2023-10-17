# Version: 20231018003845
Sequel.migration do
  change do
    create_table(:items) do
      primary_key :id, type: 'int(11)'
      column :name, 'text'
      column :position, 'bigint(20)'
      column :created_at, 'datetime', null: false
      column :updated_at, 'datetime', null: false
    end

    create_table(:schema_migrations) do
      column :filename, 'varchar(255)', null: false

      primary_key [:filename]
    end

    create_table(:things) do
      primary_key :id, type: 'int(11)'
      column :name, 'varchar(255)'
      column :label, 'bigint(20)'
      column :created_at, 'datetime', null: false
      column :updated_at, 'datetime', null: false
    end
  end
end

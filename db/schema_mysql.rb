# Version: 20231018004812
Sequel.migration do
  change do
    create_table(:article) do
      primary_key :id, type: :Bignum
      column :fiction, 'bigint'
    end

    create_table(:items) do
      primary_key :id, type: 'int'
      column :name, 'text'
      column :position, 'bigint'
      column :created_at, 'datetime', null: false
      column :updated_at, 'datetime', null: false
    end

    create_table(:label) do
      primary_key :id, type: :Bignum
      column :fiction, 'bigint'
    end

    create_table(:mysql_sequence) do
      column :name, 'varchar(40)'
      column :seq, 'bigint'
    end

    create_table(:schema_migrations) do
      column :filename, 'varchar(255)', null: false

      primary_key [:filename]
    end

    create_table(:things) do
      primary_key :id, type: 'int'
      column :name, 'varchar(255)'
      column :label, 'bigint'
      column :created_at, 'datetime', null: false
      column :updated_at, 'datetime', null: false
    end
  end
end

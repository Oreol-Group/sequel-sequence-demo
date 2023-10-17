# frozen_string_literal: true

Sequel.migration do
  up do
    create_sequence :article, if_exists: false, start: 1000

    create_table(:items) do
      primary_key :id
      String :name, text: true

      Bignum :position

      Time :created_at, null: false
      Time :updated_at, null: false
    end

    set_column_default_nextval :items, :position, :article
  end

  down do
    drop_table?(:items)

    drop_sequence :article
  end
end

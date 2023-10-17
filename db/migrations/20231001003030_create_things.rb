# frozen_string_literal: true

Sequel.migration do
  up do
    create_table!(:things) do
      primary_key :id
      String :name
      Bignum :label
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_sequence :label, if_exists: false
  end

  down do
    drop_sequence :label

    drop_table?(:things)
  end
end

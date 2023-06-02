module CreateTableProducts

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:products) do
    [
      pk()
      column(:description, :string, limit = 50)
      column(:price, :float)
    ]
  end

  add_index(:products, :description)
end

function down()
  drop_table(:products)
end

end # module
module CreateTableOrderProducts

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:order_products) do
    [
      pk()
      column(:order_id, :integer)
      column(:product_id, :integer)
      column(:quantity, :integer)
    ]
  end

  add_indices(:order_products, :order_id, :product_id)
end

function down()
  drop_table(:order_products)
end

end

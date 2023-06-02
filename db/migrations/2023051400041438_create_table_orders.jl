module CreateTableOrders

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:orders) do
    [
      pk()
      column(:client_id, :integer)
      column(:order_date, :date)
    ]
  end

  add_indices(:orders, :client_id, :order_date)
end

function down()
  drop_table(:orders)
end

end # module

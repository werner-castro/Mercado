module CreateTableClients

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:clients) do
    [
      pk()
      column(:name, :string, limit = 50)
      column(:email, :string, limit = 50)
    ]
  end

  add_index(:clients, :email)
end

function down()
  drop_table(:clients)
end

end

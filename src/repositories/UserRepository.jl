module UserRepository

import FunSQL: From, Select, Get, SQLCatalog, SQLTable, render
using Mercado.MercadoRepository
using Mercado.UserDTO: UserDto
using Mercado.UserModel: User
using SearchLight: query

export select_by_email, select_all_users

catalog = SQLCatalog(SQLTable(:users, columns = [:id, :name, :email, :password]), dialect = :postgresql)

function select_by_email(email::String)
    user = User(email=email)
    result = find(User, email = user.email)
    
    return result
end

function select_all_users()
    node = From(:users) |> Select(Get.id, Get.name, Get.email)
    q = render(catalog, node).raw
    result = query(q)
    users = dataframetostruct(UserDto, result)

    return users
end

end # module
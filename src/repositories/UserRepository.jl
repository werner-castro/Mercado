module UserRepository

import FunSQL: From, Select, Get, render
using Mercado.MercadoRepository
using Mercado.UserDTO: UserDto
using Mercado.UserModel: User

export select_by_email, select_all_users

catalog = createcatalog(:users, User)

function select_by_email(email::String)
    user = User(email=email)
    result = find(User, email = user.email)
    
    return result
end

function select_all_users()
    node = From(:users) |> Select(Get.id, Get.name, Get.email)
    result = render(catalog, node).raw |> query
    users = tomodel(UserDto, result)

    return users
end

end # module
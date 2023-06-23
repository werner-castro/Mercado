module UserRepository

using Mercado.MercadoRepository
using Mercado.UserModel: User

export select_by_email

function select_by_email(email::String)
    user = User(email=email)
    result = find(User, email = user.email)
    
    return result
end

end # module
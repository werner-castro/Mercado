module UserModel

using SearchLight, SearchLight.Validation
using Mercado.Validations
import Base: @kwdef
using SHA

export User, getmodel, gethash

@kwdef mutable struct User <: AbstractModel
    id::DbId       = DbId()
    name::String   = ""
    email::String  = ""
    password::String = ""
end

Validation.validator(::Type{User}) = ModelValidator([
    ValidationRule(:name, not_empty)
    ValidationRule(:email, not_empty)
    ValidationRule(:email, is_valid_email)
    ValidationRule(:email, is_unique)
    ValidationRule(:password, not_empty)
])

function gethash(password::String)
    return bytes2hex(sha256(password))
end
    
end # module
module ClientModel

using SearchLight, SearchLight.Validation
using Mercado.Validations
import Base: @kwdef 

export Client, modelverify 

@kwdef mutable struct Client <: AbstractModel
    id::DbId       = DbId()
    name::String   = ""
    email::String  = ""
end

Validation.validator(::Type{Client}) = ModelValidator([
    ValidationRule(:name, not_empty) 
    ValidationRule(:name, max_size_name)
    ValidationRule(:email, is_valid_email)    
])

end # module
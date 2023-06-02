module UserModel

using SearchLight, SearchLight.Validation
using Mercado.Validations
import Base: @kwdef

export User, modelverify

@kwdef mutable struct User <: AbstractModel
    id::DbId       = DbId()
    name::String   = ""
end

Validation.validator(::Type{User}) = ModelValidator([
    ValidationRule(:name, not_empty)
])

end # module
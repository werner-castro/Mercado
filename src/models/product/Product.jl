module ProductModel

using SearchLight, SearchLight.Validation
using Mercado.Validations
import Base: @kwdef

export Product, modelverify

@kwdef mutable struct Product <: AbstractModel
    id::DbId       = DbId()
    name::String   = ""
    price::Float64 = 0.0
end

Validation.validator(::Type{Product}) = ModelValidator([
    ValidationRule(:name, not_empty)
    ValidationRule(:name, max_size_name)
    ValidationRule(:price, not_empty)
    ValidationRule(:price, not_zero)
])

end # module

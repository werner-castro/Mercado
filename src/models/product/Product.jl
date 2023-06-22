module ProductModel

using SearchLight, SearchLight.Validation
using SearchLight.Requests
using Mercado.Validations
import Base: @kwdef

export Product, getmodel

@kwdef mutable struct Product <: AbstractModel
    id::DbId            = DbId()
    description::String = ""
    price::Float64      = 0.0
end

Validation.validator(::Type{Product}) = ModelValidator([
    ValidationRule(:description, not_empty)
    ValidationRule(:description, max_size_name)
    ValidationRule(:price, not_empty)
    ValidationRule(:price, not_zero)
])

end # module

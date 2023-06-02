module OrderModel

using SearchLight, SearchLight.Validation
using Mercado.Validations
import Base: @kwdef 

export Order, modelverify

@kwdef mutable struct Order <: AbstractModel
    id::DbId           = DbId()
    client_id::Int64   = 0
    order_date::String = ""
end

Validation.validator(::Type{Order}) = ModelValidator([
    ValidationRule(:client_id, not_empty)
    ValidationRule(:order_date, not_empty)
    ValidationRule(:order_date, is_valid_date)
])

end # module

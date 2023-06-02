module OrderProductModel

using SearchLight, SearchLight.Validation
using Mercado.Validations
import Base: @kwdef

export OrderProduct, modelverify

@kwdef mutable struct OrderProduct <: AbstractModel
    id::DbId          = DbId()
    order_id::Int64   = 0
    product_id::Int64 = 0
    quantity::Int64   = 0
end

Validation.validator(::Type{OrderProduct}) = ModelValidator([

])

end # module
module ItemOrderModel

using SearchLight, SearchLight.Validation
import Mercado.ProductModel: Product
import Mercado.OrderModel: Order
using Mercado.Validations
import Base: @kwdef

export ItemOrder, modelverify

@kwdef mutable struct ItemOrder <: AbstractModel
    id::DbId          = DbId()
    order::Order      = Order()
    product::Product  = Product()
    quantity::Int64   = 0
end

Validation.validator(::Type{ItemOrder}) = ModelValidator([
    ValidationRule(:order, not_empty)
    ValidationRule(:product, not_empty)
    ValidationRule(:quantity, not_empty)
    ValidationRule(:quantity, is_int)
])

end # module
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

])

end # module
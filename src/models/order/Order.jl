module OrderModel

import SearchLight.Relationships: Relationship!
using SearchLight, SearchLight.Validation
import Mercado.ClientModel: Client
using Dates: Date, format, now
using Mercado.Validations
import Base: @kwdef 

export Order, getmodel

@kwdef mutable struct Order <: AbstractModel
    id::DbId                        = DbId()
    client_id::Int64                = 0
    order_date::Union{String, Date} = Date(1900, 01, 01)
    totals::Float64                 = 0.0
    Order(id, client_id, order_date, totals) = new(id, client_id, String(order_date), totals)
end

Validation.validator(::Type{Order}) = ModelValidator([
    ValidationRule(:client_id, not_empty)
])

end # module

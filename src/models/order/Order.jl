module OrderModel

import SearchLight.Relationships: Relationship!
using SearchLight, SearchLight.Validation
import Mercado.ClientModel: Client
using Mercado.Validations
import Base: @kwdef 
import Dates: Date

export Order, modelverify

@kwdef mutable struct Order <: AbstractModel
    id::DbId                        = DbId()
    client_id::Int64                = 0
    order_date::Union{String, Date} = ""
    totals::Float64                 = 0.0
    name::String                    = ""
end

Order(name::String) = Order(name = String(name))

Validation.validator(::Type{Order}) = ModelValidator([
    ValidationRule(:client, not_empty)
    ValidationRule(:order_date, not_empty)
    ValidationRule(:order_date, is_valid_date)
])

end # module

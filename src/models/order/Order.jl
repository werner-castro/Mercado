module OrderModel

using SearchLight, SearchLight.Validation
import Mercado.ClientModel: Client
using Mercado.Validations
import Base: @kwdef 

export Order, modelverify

@kwdef mutable struct Order <: AbstractModel
    id::DbId           = DbId()
    client::Client     = Client()
    order_date::String = ""
    totals::Float64    = 0.0
end

Validation.validator(::Type{Order}) = ModelValidator([
    ValidationRule(:client, not_empty)
    ValidationRule(:order_date, not_empty)
    ValidationRule(:order_date, is_valid_date)
])

end # module

module OrderDTO

using SearchLight: DbId

export OrderDto

struct OrderDto
    id::DbId
    client_id::Int64
    order_date::Union{String, Date}
    totals::Float64
    name::String
end

end # module
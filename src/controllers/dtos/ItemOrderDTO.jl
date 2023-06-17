module ItemOrderDTO

using SearchLight: DbId

export ItemOrderDto

struct ItemOrderDto
    id::DbId
    order_id::Int64
    product_id::Int64
    quantity::Int64
    price::Float64
    total::Float64
    name::String
end

end # module
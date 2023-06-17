module ProductDTO

using SearchLight: DbId

export ProductDto

struct ProductDto
    id::DbId
    description::String
    price::Float64
end

end # module
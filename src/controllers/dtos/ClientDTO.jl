module ClientDTO

using SearchLight: DbId

export ClientDto

struct ClientDto
    id::DbId
    name::String
    email::String
end

end # module
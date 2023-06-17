module UserDTO

using SearchLight: DbId

export UserDto

struct UserDto
    id::DbId
    name::String
    email::String
end

end # module
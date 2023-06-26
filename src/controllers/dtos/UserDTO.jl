module UserDTO

using SearchLight: AbstractModel, DbId

export UserDto

struct UserDto <: AbstractModel
    id::DbId
    name::String
    email::String
end

end # module
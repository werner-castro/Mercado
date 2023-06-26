module UserDTO

using SearchLight: AbstractModel

export UserDto

struct UserDto <: AbstractModel
    id::Int32
    name::String
    email::String
end

end # module
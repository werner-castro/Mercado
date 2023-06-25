module UserService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.UserRepository as repository
import Mercado.UserModel: User, gethash
import HTTP.StatusCodes as status

export all_users, save_user, update_user_by_id, delete_user, get_user_by_id, get_user_by_email

function all_users()
    users = repository.all(User)
    length(users) > 0 || throw(NotFoundException("table USERS is empty !", "", status.NO_CONTENT, ""))

    return users
end

function save_user(user::User)
    user.password = gethash(user.password)
    result = repository.save(user)
    isequal(result, true) || throw(NotPersistedException(User, "user not persisted")) 

    return result
end

function update_user_by_id(user::User)
    isa(user.id.value, Int) || throw(ValidationError(:user, :error, "Id for update user is required"))
    result = repository.select_by_id(user)
    !isnothing(result) || throw(NotFoundException("Id of user: $(user.id) not found", "", status.NOT_FOUND, ""))
    result = repository.alter_by_id(user)

    return result
end

function delete_user(id::Int64)
    user = User(id=id)
    result = repository.select_by_id(user)
    !isnothing(result) || throw(NotFoundException("Id of user: $(user.id) not found", "", status.NOT_FOUND, ""))
    result = repository.delete(user)

    return result
end

function get_user_by_id(id::Int64)
    user = User(id=id)
    result = repository.select_by_id(user)
    !isnothing(result) || throw(NotFoundException("Id of user: $(user.id) not found", "", status.NOT_FOUND, ""))
    result = repository.select_by_id(user)

    return result
end

function get_user_by_email(email::String)
    result = repository.select_by_email(email)
    !isnothing(result) || throw(NotFoundException("Email of user: $(user.email) not found", "", status.NOT_FOUND, ""))

    return result
end    

end # module
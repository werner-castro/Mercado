module UserController

using Mercado.HandlingExceptions: handling_error
using Genie.Requests, Genie.Renderer.Json
using Mercado.UserModel: User, getmodel
import Mercado.UserService as service
import Genie.Responses: setstatus
using Genie.Router

URL = "/api/users/"

route(URL * "list", method = GET) do
    try
        return json(service.all_users())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id", method = GET) do 
    try 
        id = tryparse(Int64, params(:id))
        user = service.get_user_by_id(id)
        return json(user)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/email", method = GET) do 
    try 
        email = params(:email)
        user = service.get_user_by_email(email)
        return json(user)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try
        user = getmodel(User)
        service.save_user(user)
        setstatus(CREATED)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do
    try
        user = getmodel(User)
        setstatus(NO_CONTENT)
        return json(service.update_user_by_id(user))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do
    try
        id = tryparse(Int64, payload(:id))
        service.delete_user(id)
        setstatus(NO_CONTENT)
    catch error
        response = handling_error(error)
        return response
    end
end

end # module
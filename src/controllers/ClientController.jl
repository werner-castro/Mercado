module ClientController

using Genie.Router, Genie.Requests, Genie.Renderer.Json
import Mercado.HandlingExceptions: handling_error
import Mercado.ClientModel: Client, getmodel
import Mercado.ClientService as service
import Genie.Responses: setstatus

URL = "/api/clients/"

route(URL * "list", method = GET) do
    try
        return json(service.list_clients())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try
        client = getmodel(Client)
        setstatus(CREATED)
        service.save_client(client)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id", method = GET) do 
    try
        id = tryparse(Int64, params(:id))
        client = service.get_client_by_id(id)
        return json(client)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/name", method = GET) do 
    try
        name = params(:name) 
        client = service.get_client_by_name(name)
        return json(client)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        client = getmodel(Client)
        setstatus(NO_CONTENT)
        return json(service.update_client_by_id(client))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do 
    try
        id = tryparse(Int64, payload(:id))
        setstatus(NO_CONTENT)
        return service.remove_client_by_id(id)
    catch error
        response = handling_error(error)
        return response
    end
end

end # module
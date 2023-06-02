module ClientService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.ClientModel: Client
import HTTP.StatusCodes as status
using Mercado.ClientRepository

export list_clients, save_client, update_client_by_id, get_client_by_id, get_client_by_name, remove_client_by_id

function list_clients() 
    clients = all(Client)
    !isnothing(clients) || throw(NotFoundException("table CLIENTS is empty", "", status.NO_CONTENT, ""))

    return clients
end

function save_client(client::Client) 
    result = save(client)
    result || throw(NotFoundException(Client, "client not persisted"))

    return result
end

function update_client_by_id(client::Client)
    isa(client.id.value, Int) || throw(ValidationError(:client, :error, "Id for update product is required")) 
    result = select_by_id(client)
    !isnothing(result) || throw(NotFoundException("Id of client: $(client.id) not found", "", status.NOT_FOUND, ""))
    result = alter_by_id(client)

    return result
end

function get_client_by_id(id::Int) 
    client = Client(id=id)
    result = select_by_id(client)
    !isnothing(result) || throw(NotFoundException("Id of client: $(client.id) not found", "", status.NOT_FOUND, ""))

    return result
end

function get_client_by_name(name::String)
    client = Client(name=name)
    result = select_by_name(client)
    !isnothing(result) || throw(NotFoundException("Name of client: $(client.id) not found", "", status.NOT_FOUND, ""))

    return result
end

function remove_client_by_id(id::Int) 
    client = Client(id=id)
    result = select_by_id(client)
    !isnothing(result) || throw(NotFoundException("Id of client: $(client.id) not found", "", status.NOT_FOUND, ""))
    result = delete(client)

    return result
end

end # module
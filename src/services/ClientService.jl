module ClientService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.ClientRepository as repository
import Mercado.ClientModel: Client
import HTTP.StatusCodes as status

export list_clients, save_client, update_client_by_id, get_client_by_id, get_client_by_name, remove_client_by_id

function list_clients() 
    clients = repository.all(Client)
    !isnothing(clients) || throw(NotFoundException("table CLIENTS is empty", "", status.NO_CONTENT, ""))

    return clients
end

function save_client(client::Client) 
    result = repository.save(client)
    result || throw(NotFoundException(Client, "client not persisted"))

    return result
end

function update_client_by_id(client::Client)
    isa(client.id.value, Int) || throw(ValidationError(:client, :error, "Id for update product is required")) 
    result = repository.select_by_id(client)
    !isnothing(result) || throw(NotFoundException("Id of client: $(client.id) not found", "", status.NOT_FOUND, ""))
    result = repository.alter_by_id(client)

    return result
end

function get_client_by_id(id::Int) 
    client = Client(id=id)
    result = repository.select_by_id(client)
    !isnothing(result) || throw(NotFoundException("Id of client: $(client.id) not found", "", status.NOT_FOUND, ""))

    return result
end

function get_client_by_name(name::String)
    client = Client(name=name)
    result = repository.select_by_name(client)
    length(result) > 0 || throw(NotFoundException("Name of client: $(name) not found", "", status.NOT_FOUND, ""))

    return result
end

function remove_client_by_id(id::Int) 
    client = Client(id=id)
    result = repository.select_by_id(client)
    !isnothing(result) || throw(NotFoundException("Id of client: $(client.id) not found", "", status.NOT_FOUND, ""))
    result = repository.delete(client)

    return result
end

end # module
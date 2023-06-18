module OrderController

using Genie.Router, Genie.Requests, Genie.Renderer.Json
import Mercado.HandlingExceptions: handling_error
import Mercado.OrderService as service
import Genie.Responses: setstatus
import Mercado.OrderModel: Order
import ToStruct: tostruct
import Dates: Date

URL = "/api/orders/"

route(URL * "list", method = GET) do 
    try
        json(service.list_orders())
        setstatus(OK)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

route(URL * "select/id/:id", method = GET) do 
    try
        id = tryparse(Int64, payload(:id))
        order = service.get_order_by_id(id)
        setstatus(OK)
        json(order)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

route(URL * "select/date", method = POST) do 
    try
        order = Order(order_date = jsonpayload()["order_date"]) |> modelverify
        order = service.get_order_by_date(order)
        json(order)
        setstatus(OK)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try 
        order = tostruct(Order, jsonpayload()) |> modelverify
        service.save_order(order)
        setstatus(CREATED)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        order = tostruct(Order, jsonpayload()) |> modelverify
        json(service.update_order_by_id(order))
        setstatus(NO_CONTENT)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do 
    try
        id = tryparse(Int64, payload(:id))
        order = Order(id = id)
        service.remove_order_by_id(order)
        setstatus(NO_CONTENT)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

end # module


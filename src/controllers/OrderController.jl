module OrderController

using Genie.Router, Genie.Requests, Genie.Renderer.Json
import Mercado.HandlingExceptions: handling_error
import Mercado.OrderModel: Order, getmodel
import Mercado.OrderService as service
import Genie.Responses: setstatus
import Dates: Date

URL = "/api/orders/"

route(URL * "list", method = GET) do 
    try
        return json(service.list_orders())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id/:id", method = GET) do 
    try
        id = tryparse(Int64, payload(:id))
        order = service.get_order_by_id(id)
        return json(order)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/date", method = POST) do 
    try
        order = Order(order_date = jsonpayload()["order_date"]) |> modelverify
        order = service.get_order_by_date(order)
        json(order)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try 
        order = getmodel(Order)
        service.save_order(order)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        order = getmodel(Order)
        setstatus(NO_CONTENT)
        return json(service.update_order_by_id(order))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do 
    try
        id = tryparse(Int64, payload(:id))
        order = Order(id=id)
        setstatus(NO_CONTENT)
        service.remove_order_by_id(order)
    catch error
        response = handling_error(error)
        return response
    end
end

end # module


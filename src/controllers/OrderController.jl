module OrderController

using Genie.Router, Genie.Requests, Genie.Renderer.Json
import Mercado.HandlingExceptions: handling_error
using Mercado.OrderService
import ToStruct: tostruct
using Mercado.OrderModel
import Dates: Date

URL = "/api/orders/"

route(URL * "list", method = GET) do 
    try
        json(list_orders())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id/:id", method = GET) do 
    try
        id = tryparse(Int64, payload(:id))
        order = get_order_by_id(id)
        json(order)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/date", method = POST) do 
    try
        order = Order(order_date = jsonpayload()["order_date"]) |> modelverify
        order = get_order_by_date(order)
        json(order)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try 
        order = tostruct(Order, jsonpayload()) |> modelverify
        save_order(order)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        order = tostruct(Order, jsonpayload()) |> modelverify
        json(update_order_by_id(order))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do 
    try
        order = Order(id = id)
        remove_order_by_id(order)
        id = tryparse(Int64, payload(:id))
    catch error
        response = handling_error(error)
        return response
    end
end

end # module


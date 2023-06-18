module ItemOrderController

using Genie.Router, Genie.Requests, Genie.Renderer.Json, Genie.Responses
import Mercado.HandlingExceptions: handling_error
import Mercado.ItemOrderService: service
import Genie.Responses: setstatus
using Mercado.ItemOrderModel
import ToStruct: tostruct

URL = "/api/item_orders/"

route(URL * "list", method = GET) do 
    try
        json(service.list_all_item_orders())
        setstatus(OK)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

route(URL * "save", method = POST) do
    try
        itemOrder = tostruct(ItemOrder, jsonpayload()) |> modelverify
        service.save_item_order(itemOrder)
        setstatus(CREATED)
    catch error
        response = handling_error(error)
        setstatus(response.status)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        itemOrder = tostruct(ItemOrder, jsonpayload()) |> modelverify
        json(service.update_item_order_by_id(itemOrder))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do 
    try
        id = tryparse(Int64, payload(:id))
        itemOrder = ItemOrder(id=id)
        remove_item_order_by_id(itemOrder)
    catch error
        response = handling_error(error)
        return response
    end
end

end # module
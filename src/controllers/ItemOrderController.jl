module ItemOrderController

using Genie.Router, Genie.Requests, Genie.Renderer.Json, Genie.Responses
import Mercado.HandlingExceptions: handling_error
using Mercado.ItemOrderService
using Mercado.ItemOrderModel
import ToStruct: tostruct

URL = "/api/item_orders/"

route(URL * "list", method = GET) do 
    try
        json(list_all_item_orders())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do
    try
        itemOrder = tostruct(ItemOrder, jsonpayload())
        save_item_order(itemOrder)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        itemOrder = tostruct(ItemOrder, jsonpayload())
        json(update_item_order_by_id(itemOrder))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete", method = DELETE) do 
    try
        itemOrder = ItemOrder()
        itemOrder.id = id
        id = parse(Int64, payload(:id))
        remove_item_order_by_id(itemOrder)
    catch error
        response = handling_error(error)
        return response
    end
end

end # module
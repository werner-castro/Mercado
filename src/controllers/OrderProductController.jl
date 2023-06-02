module OrderProductController

using Genie.Router, Genie.Requests, Genie.Renderer.Json, Genie.Responses
import Mercado.HandlingExceptions: handling_error
using Mercado.OrderProductService
using Mercado.OrderProductModel
import ToStruct: tostruct

URL = "/api/orders_products/"

route(URL * "list", method = GET) do 
    try
        json(list_all_orders_products())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do
    try
        orderProduct = tostruct(OrderProduct, jsonpayload())
        save_order_product(orderProduct)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do 
    try
        orderProduct = tostruct(OrderProduct, jsonpayload())
        json(update_order_product_by_id(orderProduct))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete", method = DELETE) do 
    try
        orderProduct = OrderProduct()
        orderProduct.id = id
        id = parse(Int64, payload(:id))
        remove_order_product_by_id(orderProduct)
    catch error
        response = handling_error(error)
        return response
    end
end

end # module
module ProductController

import Mercado.HandlingExceptions: handling_error
using Genie.Requests, Genie.Renderer.Json
import Mercado.ProductService as service
using Mercado.ProductModel
import ToStruct: tostruct
using Genie.Router

URL = "/api/products/"

route(URL * "list", method = GET) do
    try
        json(service.all_product())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id", method = GET) do 
    try 
        id = tryparse(Int64, params(:id))
        product = service.get_product_by_id(id)
        json(product)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try
        product = tostruct(Product, jsonpayload()) |> modelverify
        service.save_product(product)
    catch error

        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do
    try
        product = tostruct(Product, jsonpayload()) |> modelverify
        json(service.update_product_by_id(product))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do
    try
        id = tryparse(Int64, payload(:id))
        service.delete_product(id)
    catch error 
        response = handling_error(error)
        return response
    end
end

end # module

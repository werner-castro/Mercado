module ProductController

using Genie.Router, Genie.Requests, Genie.Renderer.Json
using Mercado.HandlingExceptions
using Mercado.ProductService
using Mercado.ProductModel
import ToStruct: tostruct

URL = "/api/products/"

route(URL * "list", method = GET) do
    try
        json(all_product())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id", method = GET) do 
    try 
        id = tryparse(Int64, params(:id))
        product = get_product_by_id(id)
        json(product)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try
        product = tostruct(Product, jsonpayload()) |> modelverify
        save_product(product)
    catch error 
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do
    try
        product = tostruct(Product, jsonpayload()) |> modelverify
        json(update_product_by_id(product))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do
    try
        id = tryparse(Int64, payload(:id))
        delete_product(id)
    catch error 
        response = handling_error(error)
        return response
    end
end

end # module

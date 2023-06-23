module ProductController

import Mercado.HandlingExceptions: handling_error
using Mercado.ProductModel: Product, getmodel
using Genie.Requests, Genie.Renderer.Json
import Mercado.ProductService as service
import Genie.Responses: setstatus
using Genie.Router

URL = "/api/products/"

route(URL * "list", method = GET) do
    try
        return json(service.all_product())
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "select/id", method = GET) do 
    try 
        id = tryparse(Int64, params(:id))
        product = service.get_product_by_id(id)
        return json(product)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "save", method = POST) do 
    try
        product = getmodel(Product)
        setstatus(CREATED)
        return service.save_product(product)
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "update", method = PUT) do
    try
        product = getmodel(Product)
        setstatus(NO_CONTENT)
        return json(service.update_product_by_id(product))
    catch error
        response = handling_error(error)
        return response
    end
end

route(URL * "delete/:id", method = DELETE) do
    try
        id = tryparse(Int64, payload(:id))
        setstatus(NO_CONTENT)
        return service.delete_product(id)
    catch error 
        response = handling_error(error)
        return response
    end
end

end # module

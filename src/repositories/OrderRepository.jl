module OrderRepository

import FunSQL: From, Select, Get, Fun, Where, render
import Mercado.ClientModel: Client
import Mercado.OrderModel: Order
using Mercado.MercadoRepository

export select_order_by_date_and_total

catalog = createcatalog(:order, Order)

# função para selecionar pedido por data e valor total
function select_order_by_date_and_total(date::String, totals::Float64)
    node = From(:order)|> 
        Where( 
            Fun.and( 
                Get.date .== date, 
                Get.totals .== totals 
            ) 
        )|> 
    Select(Get.id, Get.client, Get.order_date, Get.totals)

    result = render(catalog, node).raw |> query
    
    return result
    # orders = tomodel(Order, result)

    # return orders
end

end # module
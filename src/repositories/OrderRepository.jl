module OrderRepository

import Mercado.ClientModel: Client
import Mercado.OrderModel: Order
using Mercado.MercadoRepository
using JSON

export select_order_by_date_and_total

# função para selecionar pedido por data e total
function select_order_by_date_and_total(date::String, totals::Float64)
    query = From(:order)|> 
        Where( 
            Fun.and( 
                Get.date .== date, 
                Get.totals .== totals 
            ) 
        )|> 
        Select(Get.id, Get.client, Get.order_date, Get.totals)
    
    return find(Order, SQLWhereExpression(query))
end

end # module
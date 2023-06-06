module OrderRepository

import Mercado.OrderModel: Order
using Mercado.MercadoRepository

export all, find, findone, save, delete, alter_by_id, select_by_id, select_by_date, select_by_totals, select_order_by_date_and_total

function select_by_date(order::Order)
    date = order.order_date
    find(Order, date = order.order_date)
end

function select_by_totals(order::Order)
    totals = order.totals
    find(Order, totals = order.totals)
end

# função para selecionar pedido por data e total
function select_order_by_date_and_total(date::String, totals::Float64)
    query = From(:order) |> Where( Fun.and( Get.date .== date, Get.totals .== totals ) ) |> Select(Get.id, Get.client, Get.order_date, Get.totals)
    find(Order, SQLWhereExpression(query))
end

end # module
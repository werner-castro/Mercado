module OrderRepository

import Mercado.OrderModel: Order
using Mercado.MercadoRepository

export all, find, findone, save, delete, alter_by_id, select_by_id, select_by_date

function select_by_date(order::Order)
    date = order.order_date
    find(Order, date = order.order_date)
end

end # module
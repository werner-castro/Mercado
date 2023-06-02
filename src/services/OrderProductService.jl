module OrderProductService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.OrderProductModel: OrderProduct
using Mercado.OrderProductRepository
import HTTP.StatusCodes as status

export list_all_orders_products, save_order_product, update_order_product_by_id, select_order_product_by_id, remove_order_product_by_id

list_all_orders_products() = all(OrderProduct)

save_order_product(orderProduct::OrderProduct) = insert(orderProduct)

update_order_product_by_id(orderProduct::OrderProduct) = alter_by_id(orderProduct)

select_order_product_by_id(orderProduct::OrderProduct) = select_by_id(orderProduct)

remove_order_product_by_id(orderProduct::OrderProduct) = delete_by_id(orderProduct)

end # module
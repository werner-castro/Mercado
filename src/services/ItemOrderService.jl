module ItemOrderService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.ItemOrderModel: ItemOrder
using Mercado.ItemOrderRepository
import HTTP.StatusCodes as status

export list_all_item_orders, save_item_order, update_item_order_by_id, select_item_order_by_id, remove_item_order_by_id

list_all_item_orders() = all(ItemOrder)

save_item_order(itemOrder::ItemOrder) = insert(itemOrder)

update_item_order_by_id(itemOrder::ItemOrder) = alter_by_id(itemOrder)

select_item_order_by_id(itemOrder::ItemOrder) = select_by_id(itemOrder)

remove_item_order_by_id(itemOrder::ItemOrder) = delete_by_id(itemOrder)

end # module
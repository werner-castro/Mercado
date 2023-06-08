module OrderService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.OrderRepository as repository
import HTTP.StatusCodes as status
import Mercado.OrderModel: Order

export list_orders, save_order, update_order_by_id, get_order_by_id, get_order_by_date, remove_order_by_id

function list_orders() 
    orders = repository.all(Order)
    !isnothing(orders) || throw(NotFoundException("table ORDERS is empty", "", status.NO_CONTENT, ""))
    
    return orders
end

function save_order(order::Order)
    result = repository.save(order)
    result || throw(NotPersistedException(Order, "order not persisted")) 
    
    return result
end

function update_order_by_id(order::Order)
    isa(order.id.value, Int64) || throw(NotFoundException("id of order is required", "", status.NOT_FOUND, ""))
    result = repository.select_by_id(order)
    result || throw(NotFoundException("Id of order $(order.id) not found", "", status.NOT_FOUND, ""))
    
    alter_order_by_id(order)
end

function get_order_by_date(order::Order)
    result = repository.select_by_date(order)
    length(result) > 0 || throw(NotFoundException("order with date: $(order.data) not found", "", status.NOT_FOUND, ""))
    
    return result
end 

function remove_order_by_id(id::Int64)
    isa(id, Int64) || throw(NotFoundException("id of order is required", "", status.NOT_FOUND, ""))
    order = Order(id = id)
    result = repository.select_by_id(order)
    isa(result, Order) || throw(NotFoundException("id of order: $(order.id) not found", "", status.NOT_FOUND, ""))
    result = repository.delete_order_by_id(order)

    return result
end

function get_order_by_id(id::Int64)
    isa(id, Int64) || throw(NotFoundException("id of order is required", "", status.NOT_FOUND, ""))
    order = Order(id = id)
    result = repository.select_by_id(order)
    isa(result, Order) || throw(NotFoundException("Id of Order: $(order.id) not found", "", status.NOT_FOUND, ""))
    
    return result
end

end # module

module ProductService

using Genie.Exceptions, SearchLight.Exceptions
import Mercado.ProductModel: Product
import HTTP.StatusCodes as status
using Mercado.ProductRepository

export all_product, save_product, update_product_by_id, delete_product, get_product_by_id

function all_product()
    products = all(Product)
    !isnothing(products) || throw(NotFoundException("table PRODUCTS is empty", "", status.NO_CONTENT, ""))
    
    return products
end

function save_product(product::Product)
    result = save(product)
    result || throw(NotPersistedException(Product, "product not persisted")) 

    return result
end

function update_product_by_id(product::Product)
    isa(product.id.value, Int) || throw(ValidationError(:product, :error, "Id for update product is required"))
    result = select_by_id(product)
    !isnothing(result) || throw(NotFoundException("Id of product: $(product.id) not found", "", status.NOT_FOUND, ""))
    result = alter_by_id(product)

    return result
end 

function delete_product(id::Int64)
    product = Product(id=id)
    result = select_by_id(product)
    !isnothing(result) || throw(NotFoundException("Id of product: $(product.id) not found", "", status.NOT_FOUND, ""))
    result = delete(product)
    
    return result
end

function get_product_by_id(id::Int64)
    product = Product(id=id)
    result = select_by_id(product)
    !isnothing(result) || throw(NotFoundException("Id of product: $(product.id) not found", "", status.NOT_FOUND, ""))

    return result
end

end # module

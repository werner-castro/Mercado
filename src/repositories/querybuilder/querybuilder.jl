module MercadoQueryBuilder

import SearchLight: AbstractModel, find, SQLWhereExpression
import Mercado.ProductModel: Product

export from, where, and, or, not, beetween, query

function from(model::AbstractModel)
    "FROM $(lowercase(String(nameof(model))))" * "s" * "\n"
end

function select(kwargs::Symbol...)
    string = "SELECT "
    for k = 1:lastindex(kwargs)
        string *= lowercase("$(kwargs[k])") * ", "
    end

    string *= "\n"

    return string
end

where(Expr) = return "WHERE " * "$(Expr) \n"
 
and(Expr) = return " AND " * "$(Expr) \n"

or(Expr) = return " OR " * "$(Expr) \n"

not() = return " NOT "

beetween(Expr) = return " BETWEEN " * "$(Expr) \n"

"""
query(
    Product,
    from(Product),
    select(:id, :price),
    where(:(id >= 100)),
    and(:(price>= 200)),
    or(:(price = 300))
)
"""
function query(model::DataType, kwargs...)
    qry = ""
    for k = 1:lastindex(kwargs)
        qry *= kwargs[k]
    end
    qry *= ";"
    
    return qry
    # return find(typeof(model), SQLWhereExpression(qr))
end

end # module


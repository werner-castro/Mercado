module MercadoQueryBuilder

import SearchLight: AbstractModel, find, SQLWhereExpression
import Mercado.ProductModel: Product

export FROM, SELECT, WHERE, AND, OR, NOT, BETWEEN, IF, THEN, ELSE, END, QUERY, FOR, IN, LIKE, IS, NULL

"""
```
    FROM(Product)
```
"""
function FROM(model::DataType)
    "FROM $(lowercase(String(nameof(model))))" * "s" * "\n"
end

"""
```
    SELECT(:id, :name, :price)
```
"""
function SELECT(kwargs::Symbol...)
    string = "SELECT "
    for k = 1:lastindex(kwargs)
        string *= lowercase("$(kwargs[k])") * ", "
    end

    string *= "\n"

    return string
end

"""
```
WHERE(:(id = 1))
```
"""
WHERE(Expr) = return "WHERE " * "$(Expr) \n"
 
'''
```
AND(:(description = "Produto A"))
```
'''
AND(Expr) = return "AND " * "$(Expr) \n"

'''
```
OR(:(description = "Produto B"))
```
'''
OR(Expr) = return "OR " * "$(Expr) \n"

'''
```
NOT(:(description = "Produto B"))
```
'''
NOT() = return "NOT "

'''
```
BETWEEN(:(description = "Produto B"))
```
'''
BETWEEN(Expr) = return "BETWEEN " * "$(Expr) \n"

'''
```
IF(:(description = "Produto B"))
```
'''
IF(Expr) = return "IF " * "$(Expr) \n"

'''
```
THEN(:(description = "Produto B"))
```
'''
THEN(Expr) = return "THEN " * "$(Expr) \n"

'''
```
ELSE(:(description = "Produto B"))
```
'''
ELSE(Expr) = return "ELSE " * "$(Expr) \n"

'''
```
END(:(description = "Produto B"))
```
'''
END(Expr) = return "END " * "$(Expr) \n"

'''
```
FOR(:(description = "Produto B"))
```
'''
FOR(Expr) = return "FOR " * "$(Expr) \n"

'''
``` 
IN(:(description = "Produto B"))
```
'''
IN(Expr) = return "IN " * "$(Expr) \n"

'''
```
LIKE(:(description = "Produto B"))
```
'''
LIKE(Expr) = return "LIKE " * "$(Expr) \n"

'''
``` 
IS(:(description = "Produto B"))
```
'''
IS(Expr) = return "IS " * "$(Expr) \n"

'''
```
NULL(:(description = "Produto B"))
```
'''
NULL(Expr) = return "NULL " * "$(Expr) \n"

"""
```
    QUERY(
        Product,
        FROM(Product),
        SELECT(:id, :name, :price),
        WHERE(:(id = 1)),
        AND(:(description = "Produto A")),
        OR(:(description = "Produto B"))
    )
```
"""
function QUERY(model::DataType, kwargs...)
    qry = ""
    for k = 1:lastindex(kwargs)
        qry *= kwargs[k]
    end
    qry *= ";"
    
    return qry
    # return find(typeof(model), SQLWhereExpression(qr))
end

end # module
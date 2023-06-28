module MercadoRepository

import FunSQL: SQLCatalog, SQLTable
import SearchLight: query, to_models
using SearchLight.QueryBuilder
using SearchLight 
using DataFrames

export all, find, findone, save, updateby_or_create, update_or_create, delete, alter_by_id, select_by_id, select_by_name
export select_by_date, select_by_totals, select, from, query, tomodel, to_models, createcatalog
export SQLColumn, SQLQuery, SQLWhereExpression, SQLLimit, SQLOrder, SQLRaw

tomodel(model::DataType, result_query::DataFrame) = [model(row...) for row in eachrow(result_query)]

function createcatalog(table_name::Symbol, model::DataType; dialect::Symbol = :postgresql)
    catalog = SQLCatalog(
        SQLTable(
            table_name, 
            columns = [fieldname(model, i) for i = 1:length(fieldnames(model))]
        ), 
        dialect = dialect
    )

    return catalog
end

alter_by_id(model::AbstractModel) = update_or_create(model, ignore = [:id])

function select_by_id(model::AbstractModel)
    id = model.id
    findone(typeof(model), id = model.id)
end

function select_by_date(model::AbstractModel)
    date = model.order_date
    find(typeof(model), date = model.order_date)
end

function select_by_totals(model::AbstractModel)
    totals = model.totals
    find(typeof(model), totals = model.totals)
end

function select_by_name(model::AbstractModel)
    name = model.name
    find(typeof(model), name = model.name)
end

end # module

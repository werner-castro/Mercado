module MercadoRepository

using SearchLight
using SearchLight.QueryBuilder

export all, find, findone, save, updateby_or_create, update_or_create, delete, alter_by_id, select_by_id, select_by_name
export from, select, where, limit, offset, order, group, having, prepare

###########################
# from(model::AbstractModel)
# select(:column_1, :column_2)

alter_by_id(model::AbstractModel) = update_or_create(model, ignore = [:id])

function select_by_id(model::AbstractModel)
    id = model.id
    findone(typeof(model), id = model.id)
end

function select_by_name(model::AbstractModel)
    name  = model.name
    find(typeof(model), name = model.name)
end

end # module

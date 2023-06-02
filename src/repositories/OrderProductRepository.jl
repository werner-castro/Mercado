module OrderProductRepository

import Mercado.OrderProductModel: OrderProduct
using Mercado.MercadoRepository

export all, find, findone, save, delete, alter_by_id, select_by_id

end # module
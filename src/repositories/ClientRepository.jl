module ClientRepository

import Mercado.ClientModel: Client
using Mercado.MercadoRepository

export all, find, findone, save, delete, alter_by_id, select_by_id, select_by_name

end # module

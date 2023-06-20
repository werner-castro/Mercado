module Mercado

########################################## exceptions middleware layer
include("exceptions/MercadoExceptions.jl")
include("exceptions/HandlingExceptions.jl")

########################################## dtos layer
include("controllers/dtos/OrderDTO.jl")
include("controllers/dtos/ClientDTO.jl")
include("controllers/dtos/ItemOrderDTO.jl")
include("controllers/dtos/ProductDTO.jl")
include("controllers/dtos/UserDTO.jl")

########################################## model layer
include("models/validations/Validations.jl")
include("models/client/Client.jl")
include("models/order/Order.jl")
include("models/product/Product.jl")
include("models/item order/ItemOrder.jl")
include("models/user/User.jl")

########################################## repository layer
include("repositories/MercadoRepository.jl")
include("repositories/ProductRepository.jl")
include("repositories/OrderRepository.jl")
include("repositories/ItemOrderRepository.jl")
include("repositories/ClientRepository.jl")
include("repositories/UserRepository.jl")

########################################## service layer
# adicionando os serviços
for file in readdir("src/services")
  include("services/$file")
end

using Genie

const up = Genie.up
export up

function main()
  Genie.genie(; context = @__MODULE__)
end

end # module

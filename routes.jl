using Genie.Router

# include("./src/controllers/ProductController.jl")
# include("./src/controllers/ClientController.jl")
# include("./src/controllers/OrderController.jl")
# include("./src/controllers/ItemOrderController.jl")
# include("./src/controllers/UserController.jl")

# include all folders in src/controllers
for file in readdir("./src/controllers")
    include("./src/controllers/$file.jl")
end
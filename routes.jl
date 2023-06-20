using Genie.Router

# adicionando os controladores 
for file in readdir("./src/controllers")
    include("./src/controllers/$file")
end
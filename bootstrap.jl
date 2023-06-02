(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using Mercado
const UserApp = Mercado
Mercado.main()

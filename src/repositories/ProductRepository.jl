module ProductRepository

import FunSQL: From, Select, Get, render
using Mercado.ProductDTO: ProductDto
using Mercado.ProductModel: Product
using Mercado.MercadoRepository

catalog = createcatalog(:products, Product)

end # module
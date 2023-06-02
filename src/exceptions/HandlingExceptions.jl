module HandlingExceptions

import HTTP.StatusCodes as status
using Mercado.MercadoExceptions
using SearchLight.Exceptions
using SearchLight.Validation
using Genie.Exceptions
import HTTP: Response

export handling_error

function handling_error(error)
    Response(status.INTERNAL_SERVER_ERROR, "Mensagem padrão para erro: $(error)")    
end

function handling_error(error::ErrorException)
    Response(status.BAD_REQUEST, error.msg)
end

function handling_error(error::NotFoundException)
    Response(error.code, error.message)
end

function handling_error(error::RuntimeException)
    Response(error.code, error.message)
end

function handling_error(error::InternalServerException)
    Response(error.code, error.message)
end

function handling_error(error::NotPersistedException)
    Response(status.BAD_REQUEST, error.msg)
end

function handling_error(error::ValidationError)
    Response(status.BAD_REQUEST, error.error_message)
end

function handling_error(error::InvalidModelException)
    Response(status.BAD_REQUEST, error.msg)
end
function handling_error(error::ValidationResult)
    Response(status.BAD_REQUEST, error.error_message)
end

end # module
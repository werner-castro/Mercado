module Validations

using SearchLight, SearchLight.Validation, Dates

export modelverify, not_empty, not_zero, max_size_name, is_valid_email, is_valid_date, is_int, is_string, is_unique

function modelverify(model::AbstractModel)
    result = validate(model)
    fields = fieldnames(typeof(model))
    messages = ""
    if haserrors(result)
        for f = 1:lastindex(fields)
            message_error = errors_to_string(result, fields[f])
            if message_error != ""
                messages *= "$message_error \n"
            end
        end
        throw(ValidationError(:product, :error, messages))
    end

    return model
end

function not_empty(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    isempty(getfield(m, field)) && return ValidationResult(invalid, :not_empty, "should not be empty")

    ValidationResult(valid)
end

function not_zero(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    getfield(m, field) <= 0 && return ValidationResult(invalid, :not_zero, "should not be minor or equal to 0")

    ValidationResult(valid)
end

function max_size_name(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    if isa(getfield(m, field), String) 
        length( getfield(m, field) ) <= 50 || return ValidationResult(invalid, :max_size_name, "should not be max size 50 caracters")
    end

    ValidationResult(valid)
end

function is_valid_email(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    email = getfield(m, field)
    pattern = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
    if !occursin(pattern, email)
        return ValidationResult(invalid, :is_valid_email, "email is not valid !")    
    end
    
    ValidationResult(valid)
end

function is_valid_date(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}

    isnumeric(str::AbstractString) = tryparse(Int, str) !== nothing
    
    isbissexto(year::Int) = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)

    date = (getfield(m, field))
    
    if occursin("-", date)
        date = split(date, "-")
    end

    if length(date) != 3
        return ValidationResult(invalid, :is_valid_date, "should format date: dd-mm-yyyy")
    end

    firstday = 1
    lastday = 31

    firstmonth = 1
    lastmonth = 12

    firstyear = 1900
    lastyear = Dates.year(now())

    day = date[3]
    month = date[2]
    year = date[1]
    
    if length(year) != 4 || length(month) != 2 || length(day) != 2
        return ValidationResult(invalid, :is_valid_date, "should format date: dd-mm-yyyy")
    end
  
    if !isnumeric(year) || !isnumeric(month) || !isnumeric(day)
        return ValidationResult(invalid, :is_valid_date, "values of date is numeric")
    end

    year = parse(Int, year)
    month = parse(Int, month)
    day = parse(Int, day)

    year <= lastyear || return ValidationResult(invalid, :is_valid_date, "year is not better $(lastyear)")
    
    month <= Dates.month(now())  || return ValidationResult(invalid, :is_valid_date, "month is not better $( Dates.month(now()) )") 

    day <= Dates.day(now()) || return ValidationResult(invalid, :is_valid_date, "day is not better $( Dates.day(now()) )") 

    if year ∉ [firstyear:lastyear...] || month ∉ [firstmonth:lastmonth...] || day ∉ [firstday:lastday...]
        return ValidationResult(invalid, :is_valid_date, "values for year: better 1900, month: 1 and 12, day: 1 and 31")
    end

    if month == 2 && (day > 29 || (day == 29 && !isbissexto(year)))
        return ValidationResult(invalid, :is_valid_date, "days of month february go to 1 at day 29")
    end

    ValidationResult(valid)
end

function is_int(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    isa(getfield(m, field), Int) || return ValidationResult(invalid, :is_int, "should be an int")

    ValidationResult(valid)
end

function is_string(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    isa(getfield(m, field), String) || return ValidationResult(invalid, :is_string, "should be an string")

    ValidationResult(valid)
end

function is_unique(field::Symbol, m::T)::ValidationResult where {T<:AbstractModel}
    obj = findone(typeof(m); NamedTuple(field => getfield(m, field))... )
    if ( obj !== nothing && ! ispersisted(m) )
      return ValidationResult(invalid, :is_unique, "already exists")
    end

    ValidationResult(valid)
end

end # module
def first_error(object)
  message = object.errors.messages.first[1][0]
  location = object.errors.messages.first[0]
  "#{location.capitalize.to_s.gsub(/_/, ' ')} #{message}"
end
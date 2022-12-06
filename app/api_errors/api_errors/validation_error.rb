module ApiErrors
  class ValidationError < Base
    def initialize(details = nil)
      super(details)
      @http_code = 422 # Unprocessable Entity
      @id = 'validation_error'
      @developer_message = 'Some fields in the request are incorrect'
    end
  end
end

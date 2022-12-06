module ApiErrors
  class InternalServerError < Base
    def initialize(details = nil)
      super(details)
      @http_code = 500 # Internal server error
      @id = 'internal_server_error'
      @developer_message = 'Generic, no handled runtime error. Contact with the backend team'
    end
  end
end

module ApiErrors
  class Base < StandardError
    attr_reader :http_code, :id, :developer_message, :details

    def initialize(details = nil)
      @details = details
    end
  end
end

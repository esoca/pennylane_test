class AppController < ActionController::API
  rescue_from StandardError, with: :standard_error_handler

  def standard_error_handler(err)
    @api_error = err if err.is_a?(ApiErrors::Base)

    @api_error ||= begin
      details = if Rails.env.development?
        {
          exception: err.class.to_s,
          message: err.message,
          app_traces: Rails.backtrace_cleaner.clean(err.backtrace),
        }
      end

      ApiErrors::InternalServerError.new(details)
    end

    render template: 'api_errors/show', status: @api_error.http_code
  end
end

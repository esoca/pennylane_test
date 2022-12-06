class AppContract < Dry::Validation::Contract
  config.messages.default_locale = :en

  def self.validate!(data)
    result = self.new.call(data.to_unsafe_h)

    raise ApiErrors::ValidationError.new(result.errors.to_h) unless result.success?

    result.to_h
  end
end

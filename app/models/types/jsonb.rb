module Types
  class Jsonb < ActiveRecord::Type::Value
    def cast(value)
      return unless value

      value = JSON.parse(value)

      value.with_indifferent_access
    end

    def serialize(value)
      return unless value

      JSON.generate(value)
    end
  end
end

ActiveRecord::Type.register(:jsonb, Types::Jsonb)

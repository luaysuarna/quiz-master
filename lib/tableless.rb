class Tableless

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Callbacks
  extend  ActiveModel::Naming

  define_model_callbacks :initialize, :save

  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat( vars )
    super
  end

  def self.attributes
   @attributes
  end

  def initialize(attributes={})
    run_callbacks :initialize do
      attributes && attributes.each do |name, value|
        send("#{name}=", value) if respond_to? name.to_sym
      end
    end
  end

  def assign(params)
    params.each_pair do |key, value|
      send(:"#{key}=", value) if respond_to?(:"#{key}=")
    end
    return self
  end

  def persisted?
    false
  end

  def self.inspect
    "#<#{ self.to_s} #{ self.attributes.collect{ |e| ":#{ e }" }.join(', ') }>"
  end

  def stripe_rescue
    begin
      if self.valid?
        yield
        return true
      else
        return false
      end
    rescue Stripe::InvalidRequestError => error
      errors.add(:stripe, spurce_error(error))
      return false
    rescue Stripe::AuthenticationError => error
      errors.add(:stripe, spurce_error(error))
      return false
    rescue Stripe::APIConnectionError => error
      errors.add(:stripe, spurce_error(error))
      return false
    rescue Stripe::StripeError => error
      errors.add(:stripe, spurce_error(error))
      return false
    end
  end

  def self.scope(name, body)
    singleton_class.send(:define_method, name, &body)
  end

  private
  
    def spurce_error(error)
      if error.json_body
        body = error.json_body
        err  = body[:error]
        return "[#{err[:type]}] : #{err[:message]}"
      else
        return error
      end
    end

end

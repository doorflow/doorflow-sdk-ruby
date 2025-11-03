module DoorFlow
  # Base class for all DoorFlow resources
  #
  # This class provides common functionality for all resource types,
  # including conversion from API models and attribute access.
  #
  # @abstract Subclass and override methods to create resource classes
  # @example Creating a resource subclass
  #   class Person < Resource
  #     def self.create(params = {})
  #       response = client.people_api.create_person(params)
  #       from_api_model(response)
  #     end
  #   end
  class Resource
    # @return [String] the unique identifier for this resource
    attr_reader :id

    # @return [Hash] the attributes hash for this resource
    attr_reader :attributes

    # Create a new resource instance
    # @param attributes [Hash] the attributes for this resource
    def initialize(attributes = {})
      @attributes = attributes
      @id = attributes['id'] || attributes[:id]

      # Set attribute accessors
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
        self.class.send(:attr_reader, key) unless respond_to?(key)
      end
    end

    # Convert generated API model to Resource
    # @param model [Object, nil] an API model object from the generated client
    # @return [Resource, nil] a resource instance, or nil if model is nil
    def self.from_api_model(model)
      return nil if model.nil?

      attributes = if model.respond_to?(:to_hash)
        model.to_hash
      elsif model.respond_to?(:to_h)
        model.to_h
      else
        {}
      end

      new(attributes)
    end

    # Convert array of API models to Resources
    # @param models [Array] array of API model objects
    # @return [Array<Resource>] array of resource instances
    def self.from_api_models(models)
      return [] if models.nil? || models.empty?
      models.map { |model| from_api_model(model) }
    end

    # String representation of the resource
    # @return [String] a string showing the class name and ID
    def to_s
      "#<#{self.class.name} id=#{id}>"
    end

    # Detailed string representation for debugging
    # @return [String] a string showing class, object ID, and resource ID
    def inspect
      "#<#{self.class.name}:0x#{object_id.to_s(16)} id=#{id}>"
    end

    protected

    # Get or create the API client for this resource class
    # @return [DoorFlow::Client] the API client instance
    def self.client
      @client ||= DoorFlow::Client.new
    end
  end
end

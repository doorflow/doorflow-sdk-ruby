module DoorFlow
  # Base class for all DoorFlow resources
  #
  # This class provides common functionality for all resource types,
  # including conversion from API models and attribute access.
  #
  # Resources can be created via class methods (global config) or via
  # client instance (recommended for web apps).
  #
  # @example Using client instance (recommended)
  #   client = DoorFlow::Client.new(auth: auth)
  #   person = client.people.retrieve(123)
  #   person.update(first_name: 'Jane')
  #
  # @example Using global config (for scripts)
  #   DoorFlow.access_token = 'your_token'
  #   person = DoorFlow::Person.retrieve(123)
  class Resource
    # @return [String] the unique identifier for this resource
    attr_reader :id

    # @return [Hash] the attributes hash for this resource
    attr_reader :attributes

    # Create a new resource instance
    # @param attributes [Hash] the attributes for this resource
    # @param client [DoorFlow::Client, nil] optional client for instance methods
    def initialize(attributes = {}, client: nil)
      @attributes = attributes
      @id = attributes['id'] || attributes[:id]
      @_client = client

      # Set attribute accessors
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
        self.class.send(:attr_reader, key) unless respond_to?(key)
      end
    end

    # Get the client associated with this resource
    # Falls back to creating a global client if none set
    # @return [DoorFlow::Client] the client instance
    def _client
      @_client || self.class.client
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

    # Prepare image parameters for API calls
    # Accepts multiple input formats and converts to data URI format expected by the API
    #
    # Supported input formats:
    # - image_base64: Already formatted data URI (passed through unchanged)
    # - image_file: File path (String) or File object - will be read, encoded, and formatted
    # - image_data + image_mime_type: Raw base64 data with explicit MIME type
    #
    # @param params [Hash] the params hash to process
    # @return [Hash] params with image converted to data URI format
    #
    # @example Using a file path
    #   Person.create(first_name: 'John', image_file: '/path/to/photo.jpg')
    #
    # @example Using raw base64
    #   Person.create(first_name: 'John', image_data: raw_base64, image_mime_type: 'image/jpeg')
    #
    # @example Using pre-formatted data URI (unchanged)
    #   Person.create(first_name: 'John', image_base64: 'data:image/jpeg;base64,...')
    def self.prepare_image_params(params)
      params = params.dup

      # Handle file path or File object
      if params[:image_file]
        file = params.delete(:image_file)
        file_path = file.is_a?(String) ? file : file.path

        if File.exist?(file_path)
          require "base64"
          mime_type = detect_mime_type(file_path)
          encoded = Base64.strict_encode64(File.binread(file_path))
          params[:image_base64] = "data:#{mime_type};base64,#{encoded}"
        end
      end

      # Handle raw base64 + explicit mime type
      if params[:image_data] && !params[:image_base64]
        data = params.delete(:image_data)
        mime_type = params.delete(:image_mime_type) || "image/png"
        params[:image_base64] = "data:#{mime_type};base64,#{data}"
      end

      # Clean up image_mime_type if it wasn't used
      params.delete(:image_mime_type)

      params
    end

    # Detect MIME type from file extension
    # @param file_path [String] path to the file
    # @return [String] MIME type
    def self.detect_mime_type(file_path)
      case File.extname(file_path).downcase
      when ".png" then "image/png"
      when ".jpg", ".jpeg" then "image/jpeg"
      when ".gif" then "image/gif"
      when ".webp" then "image/webp"
      else "image/png"
      end
    end
  end
end

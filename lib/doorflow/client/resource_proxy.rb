module DoorFlow
  class Client
    # Base class for resource proxies
    #
    # Resource proxies provide a Stripe-like API for accessing DoorFlow resources
    # while maintaining a reference to the client for authentication.
    #
    # @abstract Subclass and implement resource-specific methods
    class ResourceProxy
      # @return [DoorFlow::Client] the client instance
      attr_reader :client

      # Create a new resource proxy
      # @param client [DoorFlow::Client] the client instance to use for API calls
      def initialize(client)
        @client = client
      end

      protected

      # Convert API response to resource, attaching client reference
      # @param model [Object] the API response model
      # @param resource_class [Class] the resource class to instantiate
      # @return [DoorFlow::Resource] the resource instance with client attached
      def to_resource(model, resource_class)
        return nil if model.nil?

        attributes = if model.respond_to?(:to_hash)
          model.to_hash
        elsif model.respond_to?(:to_h)
          model.to_h
        else
          {}
        end

        resource = resource_class.new(attributes)
        resource.instance_variable_set(:@_client, @client)
        resource
      end

      # Convert array of API models to resources
      # @param models [Array] array of API model objects
      # @param resource_class [Class] the resource class to instantiate
      # @return [Array<DoorFlow::Resource>] array of resource instances
      def to_resources(models, resource_class)
        return [] if models.nil? || models.empty?
        models.map { |model| to_resource(model, resource_class) }
      end

      # Build a ListObject from an API response
      # @param response [Object] the API response
      # @param resource_class [Class] the resource class
      # @param params [Hash] the original query params
      # @return [DoorFlow::ListObject] paginated list of resources
      def build_list_object(response, resource_class, params = {})
        raw_data = response.respond_to?(:data) ? response.data : response
        raw_data = [raw_data] unless raw_data.is_a?(Array)
        resources = to_resources(raw_data, resource_class)

        ListObject.new(
          data: resources,
          total: response.respond_to?(:total) ? response.total : resources.size,
          page: params[:page],
          per_page: params[:per_page],
          resource_class: resource_class,
          client: @client
        )
      end

      # Prepare image parameters for API calls
      # Supports file paths, File objects, and base64 data
      # @param params [Hash] the params hash to process
      # @return [Hash] params with image converted to data URI format
      def prepare_image_params(params)
        params = params.dup

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

        if params[:image_data] && !params[:image_base64]
          data = params.delete(:image_data)
          mime_type = params.delete(:image_mime_type) || "image/png"
          params[:image_base64] = "data:#{mime_type};base64,#{data}"
        end

        params.delete(:image_mime_type)
        params
      end

      # Detect MIME type from file extension
      # @param file_path [String] path to the file
      # @return [String] MIME type
      def detect_mime_type(file_path)
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
end

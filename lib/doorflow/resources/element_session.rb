module DoorFlow
  module Resources
    # Represents a DoorFlow Elements session token
    #
    # Element sessions provide short-lived JWT tokens for embedding
    # DoorFlow widgets (admin or member) in your application via iframes.
    #
    # @example Create an admin session
    #   client = DoorFlow::Client.new(access_token: 'your_token')
    #   session = client.element_sessions.create(
    #     person_id: 123,
    #     widget_type: 'admin'
    #   )
    #   session.token      #=> "eyJhbGciOiJIUzI1NiJ9..."
    #   session.expires_in  #=> 900
    class ElementSession < Resource
      # @return [String] the JWT session token
      def token
        @attributes[:token]
      end

      # @return [Integer] seconds until the token expires
      def expires_in
        @attributes[:expires_in]
      end
    end
  end
end

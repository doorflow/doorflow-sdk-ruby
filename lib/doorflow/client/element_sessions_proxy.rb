module DoorFlow
  class Client
    # Base proxy for Element Sessions — handles the HTTP call
    #
    # @api private
    class ElementSessionsProxy < ResourceProxy
      def create_session(widget_type:, member:, credentials: nil)
        params = {
          widget_type: widget_type,
          member: {
            external_id: member[:external_id],
            name:        member[:name],
            email:       member[:email]
          }
        }
        params[:credentials] = credentials if credentials
        response = post("/api/3/element_sessions", params)
        to_resource(response, Resources::ElementSession)
      end

      private

      def post(path, params)
        api_client = client.send(:api_client)
        config = api_client.config

        url = "#{config.scheme}://#{config.host}#{path}"
        token = client.access_token

        conn = Faraday.new do |f|
          f.request :json
          f.response :json, parser_options: { symbolize_names: true }
          f.adapter Faraday.default_adapter
        end

        response = conn.post(url) do |req|
          req.headers["Authorization"] = "Bearer #{token}"
          req.headers["Content-Type"] = "application/json"
          req.body = params.to_json
        end

        unless response.success?
          raise DoorFlow::ApiError.new(
            code: response.status,
            response_body: response.body
          ), "Element session creation failed (#{response.status})"
        end

        response.body
      end
    end

    # Proxy for creating admin widget sessions
    #
    # @example
    #   session = client.admin_sessions.create(
    #     member: {
    #       external_id: "usr_123",
    #       name: "Alice Anderson",
    #       email: "alice@example.com"
    #     },
    #     credentials: ["mobile_access", "pin"]
    #   )
    #   session.token      #=> "eyJhbGciOiJIUzI1NiJ9..."
    #   session.expires_in  #=> 900
    class AdminSessionsProxy < ElementSessionsProxy
      def create(member:, credentials: nil)
        create_session(widget_type: "admin", member: member, credentials: credentials)
      end
    end

    # Proxy for creating member widget sessions
    #
    # @example
    #   session = client.member_sessions.create(
    #     member: {
    #       external_id: "usr_123",
    #       name: "Alice Anderson",
    #       email: "alice@example.com"
    #     },
    #     credentials: ["mobile_access", "pin"]
    #   )
    #   session.token      #=> "eyJhbGciOiJIUzI1NiJ9..."
    #   session.expires_in  #=> 900
    class MemberSessionsProxy < ElementSessionsProxy
      def create(member:, credentials: nil)
        create_session(widget_type: "member", member: member, credentials: credentials)
      end
    end
  end
end

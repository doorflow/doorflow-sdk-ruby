module DoorFlow
  class Client
    # Proxy for Channels (doors) resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List channels
    #   channels = client.channels.list
    #
    #   # Unlock a door
    #   client.channels.unlock(123)
    class ChannelsProxy < ResourceProxy
      # List all channels
      # @param params [Hash] Query parameters (page, per_page, site_id, etc.)
      # @return [DoorFlow::ListObject] paginated list of channels
      def list(params = {})
        response = client.channels_api.list_channels(params)
        build_list_object(response, Resources::Channel, params)
      end

      # Retrieve a channel by ID
      # @param id [String, Integer] Channel ID
      # @return [DoorFlow::Resources::Channel]
      def retrieve(id)
        response = client.channels_api.get_channel(id)
        to_resource(response, Resources::Channel)
      end

      # Unlock a channel (door)
      # @param id [String, Integer] Channel ID
      # @return [Boolean] true if successful
      def unlock(id)
        client.channels_api.unlock_channel(id)
        true
      end

      # Lock down a channel
      # @param id [String, Integer] Channel ID
      # @return [Boolean] true if successful
      def lockdown(id)
        client.channels_api.lockdown_channel(id)
        true
      end

      # Admit entry through a channel
      # @param id [String, Integer] Channel ID
      # @return [Boolean] true if successful
      def admit(id)
        client.channels_api.admit_channel(id)
        true
      end

      # Set auto-unlock schedule
      # @param id [String, Integer] Channel ID
      # @param params [Hash] Schedule parameters
      # @return [Boolean] true if successful
      def auto_unlock(id, params = {})
        client.channels_api.auto_unlock_channel(id, params)
        true
      end
    end
  end
end

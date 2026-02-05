module DoorFlow
  module Resources
  # Channel resource for managing door controllers
  #
  # Channels represent physical door controllers in the DoorFlow system.
  # They can be controlled remotely to unlock doors, enable lockdown mode,
  # set auto-unlock schedules, and manage encryption keys.
  #
  # @example Unlocking a door
  #   channel = DoorFlow::Channel.retrieve('channel_123')
  #   channel.unlock(duration: 5)
  #
  # @example Admitting a specific person
  #   channel = DoorFlow::Channel.retrieve('channel_123')
  #   channel.admit_person('person_456')
  #
  # @example Enabling lockdown mode
  #   channel = DoorFlow::Channel.retrieve('channel_123')
  #   channel.lockdown(card_lockdown: true, rex_lockdown: true)
  class Channel < Resource
    # Retrieve a channel by ID
    # @param id [String] Channel ID
    # @return [DoorFlow::Channel]
    # @raise [DoorFlow::ApiError] if the channel is not found
    def self.retrieve(id)
      response = client.channels_api.get_channel(id)
      from_api_model(response)
    end

    # List all channels
    def self.list(params = {})
      response = client.channels_api.list_channels(params)

      # Handle both array response and object with data property
      raw_data = response.respond_to?(:data) ? response.data : response
      raw_data = [raw_data] unless raw_data.is_a?(Array)
      channels = from_api_models(raw_data)

      ListObject.new(
        data: channels,
        total: response.respond_to?(:total) ? response.total : channels.size,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Admit through channel (any person)
    def admit(params = {})
      response = _client.channels_api.admit_channel(@id, params)
      from_api_model(response)
    end

    # Admit specific person through channel
    def admit_person(person_id)
      request = { person_id: person_id }
      response = _client.channels_api.admit_person(@id, request)
      from_api_model(response)
    end

    # Set auto-unlock shift
    def auto_unlock(params = {})
      response = _client.channels_api.auto_unlock_channel(@id, params)
      from_api_model(response)
    end

    # Enable lockdown mode
    def lockdown(params = {})
      response = _client.channels_api.lockdown_channel(@id, params)
      from_api_model(response)
    end

    # Disable lockdown mode
    def unlockdown
      response = _client.channels_api.unlockdown_channel(@id)
      from_api_model(response)
    end

    # Return channel to normal mode
    def normal
      response = _client.channels_api.normal_channel(@id)
      from_api_model(response)
    end

    # Unlock channel (unlock mode)
    def unlock(params = {})
      response = _client.channels_api.unlock_channel(@id, params)
      from_api_model(response)
    end

    # Regenerate encryption key
    def regenerate_encryption_key
      response = _client.channels_api.regenerate_encryption_key(@id)
      from_api_model(response)
    end

    # Remove encryption key
    def remove_encryption_key
      response = _client.channels_api.remove_encryption_key(@id)
      from_api_model(response)
    end
  end
  end
end

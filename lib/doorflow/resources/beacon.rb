module DoorFlow
  class Beacon < Resource
    def self.create(params = {})
      response = client.beacons_api.create_beacon(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.beacons_api.get_beacon(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.beacons_api.list_beacons(params)
      beacons = from_api_models(response.data || response)

      ListObject.new(
        data: beacons,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.beacons_api.update_beacon(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.beacons_api.delete_beacon(@id)
      true
    rescue
      false
    end
  end
end

# DoorFlow::Site

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the site |  |
| **name** | **String** | Name of the site (required) |  |
| **ip_address** | **String** | Primary IP address for the site (deprecated - use site_ips instead) | [optional] |
| **time_zone** | **String** | IANA time zone identifier for this site | [optional] |
| **notes** | **String** | Additional notes about this site | [optional] |
| **site_ips** | [**Array&lt;SiteSiteIpsInner&gt;**](SiteSiteIpsInner.md) | Array of IP address ranges associated with this site |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Site.new(
  id: 25,
  name: Main Office,
  ip_address: 192.168.1.0/24,
  time_zone: America/New_York,
  notes: Corporate headquarters building,
  site_ips: null
)
```


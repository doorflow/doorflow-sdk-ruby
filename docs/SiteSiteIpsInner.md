# DoorFlow::SiteSiteIpsInner

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ip_address** | **String** | IP address or CIDR range | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::SiteSiteIpsInner.new(
  ip_address: 192.168.1.0/24
)
```


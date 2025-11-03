# DoorFlow::ChannelLockdown

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message** | **String** | Lockdown status message | [optional] |
| **card_lockdown** | [**ChannelLockdownCardLockdown**](ChannelLockdownCardLockdown.md) |  | [optional] |
| **rex_lockdown** | [**ChannelLockdownRexLockdown**](ChannelLockdownRexLockdown.md) |  | [optional] |
| **aux_lockdown** | [**ChannelLockdownAuxLockdown**](ChannelLockdownAuxLockdown.md) |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ChannelLockdown.new(
  message: Cards and PINs will be rejected,
  card_lockdown: null,
  rex_lockdown: null,
  aux_lockdown: null
)
```


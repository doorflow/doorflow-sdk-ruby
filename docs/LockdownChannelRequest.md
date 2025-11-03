# DoorFlow::LockdownChannelRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **card_lockdown** | **Boolean** | Lock down card access | [optional] |
| **rex_lockdown** | **Boolean** | Lock down REX (Request to Exit) | [optional] |
| **aux_lockdown** | **Boolean** | Lock down AUX inputs | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::LockdownChannelRequest.new(
  card_lockdown: true,
  rex_lockdown: false,
  aux_lockdown: false
)
```


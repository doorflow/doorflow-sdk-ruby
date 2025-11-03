# DoorFlow::Account

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Unique hashid identifier for the account |  |
| **name** | **String** | Name of the account |  |
| **time_zone** | **String** | Account&#39;s time zone (IANA time zone database format) |  |
| **monitored** | **Boolean** | Whether the account is being monitored |  |
| **reseller** | [**AccountReseller**](AccountReseller.md) |  | [optional] |
| **sync** | [**AccountSync**](AccountSync.md) |  |  |
| **user** | [**AccountUser**](AccountUser.md) |  |  |
| **passport** | [**AccountPassport**](AccountPassport.md) |  |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Account.new(
  id: abc123xyz,
  name: Acme Corporation,
  time_zone: America/New_York,
  monitored: true,
  reseller: null,
  sync: null,
  user: null,
  passport: null
)
```


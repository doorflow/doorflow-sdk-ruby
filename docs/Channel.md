# DoorFlow::Channel

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the channel |  |
| **name** | **String** | Name of the channel/door controller |  |
| **mac_address** | **String** | MAC address of the controller (format aa:bb:cc:dd:ee:ff) |  |
| **status** | **String** | Current connection status of the channel |  |
| **unit** | **Integer** | Unit number for multi-channel controllers |  |
| **model** | **String** | Controller model number | [optional] |
| **model_long** | **String** | Full descriptive model name | [optional] |
| **serial_number** | **String** | Serial number of the controller | [optional] |
| **card_format** | **String** | Card format configuration | [optional] |
| **pin_format** | **String** | PIN format configuration | [optional] |
| **freescale_version** | **String** | Freescale firmware version | [optional] |
| **pic_version** | **String** | PIC firmware version | [optional] |
| **reader_device_class_name** | **String** | Reader device class identifier | [optional] |
| **site_id** | **Integer** | ID of the site this channel belongs to | [optional] |
| **updated_at** | **Time** | Timestamp of last update | [optional] |
| **created_at** | **Time** | Timestamp of creation | [optional] |
| **sync** | [**ChannelSync**](ChannelSync.md) |  |  |
| **lockdown** | [**ChannelLockdown**](ChannelLockdown.md) |  | [optional] |
| **mode** | [**ChannelMode**](ChannelMode.md) |  |  |
| **auto_unlock** | [**ChannelAutoUnlock**](ChannelAutoUnlock.md) |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Channel.new(
  id: 1340,
  name: Front Door,
  mac_address: 00:11:22:33:44:55,
  status: null,
  unit: 1,
  model: IPBR-2,
  model_long: 2 channel IP Controller,
  serial_number: null,
  card_format: null,
  pin_format: null,
  freescale_version: null,
  pic_version: null,
  reader_device_class_name: null,
  site_id: null,
  updated_at: null,
  created_at: null,
  sync: null,
  lockdown: null,
  mode: null,
  auto_unlock: null
)
```


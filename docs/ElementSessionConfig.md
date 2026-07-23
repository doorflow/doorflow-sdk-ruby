# DoorFlow::ElementSessionConfig

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **theme** | **String** |  | [optional][default to &#39;light&#39;] |
| **accent_color** | **String** | 3- or 6-digit hex (e.g. &#x60;#FF6600&#x60;). | [optional] |
| **border_radius** | **Integer** |  | [optional][default to 8] |
| **font_family** | **String** | CSS font-family stack. Restricted to letters, digits, hyphens, spaces, commas, and single quotes.  | [optional] |
| **manage_groups** | **Boolean** |  | [optional][default to true] |
| **show_member** | **Boolean** |  | [optional][default to true] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ElementSessionConfig.new(
  theme: null,
  accent_color: #FF6600,
  border_radius: null,
  font_family: Inter, -apple-system, sans-serif,
  manage_groups: null,
  show_member: null
)
```


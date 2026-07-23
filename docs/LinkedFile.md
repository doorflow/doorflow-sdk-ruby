# DoorFlow::LinkedFile

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **uuid** | **String** | Unique identifier for this linked file | [optional] |
| **entity_type** | **String** | Type of the parent entity | [optional] |
| **entity_uuid** | **String** | UUID of the parent entity | [optional] |
| **file_role** | **String** | Role of this file (e.g. background_front, background_back, logo) | [optional] |
| **url** | **String** | URL to download the file, or null if not yet uploaded | [optional] |
| **content_type** | **String** | MIME type of the file | [optional] |
| **created_at** | **Time** |  | [optional] |
| **updated_at** | **Time** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::LinkedFile.new(
  uuid: null,
  entity_type: null,
  entity_uuid: null,
  file_role: null,
  url: null,
  content_type: null,
  created_at: null,
  updated_at: null
)
```


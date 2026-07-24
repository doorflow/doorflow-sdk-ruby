# DoorFlow::CardTemplate

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Server-assigned identifier |  |
| **uuid** | **String** | Client-generated UUID (RFC 4122) |  |
| **name** | **String** | Template display name, unique per account |  |
| **template_type_code** | **String** | References a template type code |  |
| **card_type** | **String** | Card finish/format | [optional] |
| **double_sided** | **Boolean** | Whether the card has a reverse side | [optional] |
| **orientation_front** | **String** | P &#x3D; Portrait, L &#x3D; Landscape | [optional] |
| **orientation_back** | **String** | P &#x3D; Portrait, L &#x3D; Landscape | [optional] |
| **default_template** | **Boolean** | Whether this is the account default template | [optional] |
| **background_image_front_url** | **String** | URL to the front background image, or null if not set | [optional] |
| **background_image_back_url** | **String** | URL to the back background image, or null if not set | [optional] |
| **template_objects** | **Array&lt;Object&gt;** | Free-form JSONB objects representing layout elements on this template | [optional] |
| **owner_id** | **Integer** | ID of the user who owns this template, or null if unowned. Set server-side on create. May be reassigned via PATCH by the current owner or by any admin in the account; the new value must be the ID of an admin in the same account.  | [optional] |
| **editable_by** | **String** | Who can edit this template | [optional] |
| **deleted_at** | **Time** | Soft-delete timestamp. Null for live templates. Writable via PATCH: sending a non-null value soft-deletes the template; sending null restores it. Soft-deleted templates are excluded from index by default (see include_deleted).  | [optional] |
| **deleted_by_id** | **Integer** | ID of the user who soft-deleted this template, set server-side from the authenticated user when deleted_at is written. Cleared when deleted_at is cleared.  | [optional][readonly] |
| **linked_files** | [**Array&lt;LinkedFile&gt;**](LinkedFile.md) | Files linked to this template (images, fonts, etc.) | [optional] |
| **created_at** | **Time** | ISO 8601 UTC timestamp. | [optional] |
| **updated_at** | **Time** | ISO 8601 UTC timestamp. | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardTemplate.new(
  id: 42,
  uuid: 550E8400-E29B-41D4-A716-446655440000,
  name: Staff Card,
  template_type_code: ISO_CARD,
  card_type: standard,
  double_sided: true,
  orientation_front: P,
  orientation_back: L,
  default_template: false,
  background_image_front_url: null,
  background_image_back_url: null,
  template_objects: null,
  owner_id: null,
  editable_by: null,
  deleted_at: null,
  deleted_by_id: null,
  linked_files: null,
  created_at: null,
  updated_at: null
)
```


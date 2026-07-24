# DoorFlow::CardTemplateInputCardTemplate

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **uuid** | **String** | Client-generated UUID (required for creation) | [optional] |
| **name** | **String** | Template display name (required for creation) | [optional] |
| **template_type_id** | **Integer** | ID of the template type. Prefer template_type_code for portability across environments | [optional] |
| **template_type_code** | **String** | Code of the template type (e.g. ISO_CARD_STANDARD). Resolved server-side; takes precedence over template_type_id if both are given | [optional] |
| **card_type** | **String** |  | [optional] |
| **double_sided** | **Boolean** |  | [optional] |
| **orientation_front** | **String** |  | [optional] |
| **orientation_back** | **String** |  | [optional] |
| **default_template** | **Boolean** |  | [optional] |
| **template_objects** | **Array&lt;Object&gt;** | Free-form JSONB objects representing layout elements. Replaces the entire array on update | [optional] |
| **editable_by** | **String** | Who can edit this template | [optional] |
| **owner_id** | **Integer** | Reassign ownership. Allowed for the current owner or any admin in the account. The new owner must be an admin in the same account. Ignored on create (owner is set server-side from the authenticated user).  | [optional] |
| **deleted_at** | **Time** | Soft-delete timestamp. PATCH only. Setting a non-null value soft-deletes the template; setting null restores it. The deleted_by_id field is set server-side. For permanent deletion, use DELETE /card_templates/{id}.  | [optional] |
| **change_request_id** | **String** | Idempotency key for this change request | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardTemplateInputCardTemplate.new(
  uuid: null,
  name: null,
  template_type_id: null,
  template_type_code: ISO_CARD_STANDARD,
  card_type: null,
  double_sided: null,
  orientation_front: null,
  orientation_back: null,
  default_template: null,
  template_objects: null,
  editable_by: null,
  owner_id: null,
  deleted_at: null,
  change_request_id: null
)
```


# DoorFlow::PersonInput

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **first_name** | **String** | First name (required for creation) | [optional] |
| **last_name** | **String** | Last name (required for creation) | [optional] |
| **salutation** | **String** | Salutation or title | [optional] |
| **job_title** | **String** | Job title | [optional] |
| **email** | **String** | Email address (must be unique within account if provided) | [optional] |
| **department** | **String** | Department name | [optional] |
| **enabled** | **Boolean** | Whether the person is enabled for access | [optional][default to true] |
| **valid_from** | **Time** | Access valid from this date/time | [optional] |
| **valid_to** | **Time** | Access valid until this date/time | [optional] |
| **image_base64** | **String** | Base64-encoded image data for person&#39;s photo | [optional] |
| **image_remote_url** | **String** | Remote URL to fetch person&#39;s photo from (set to empty string to delete image) | [optional] |
| **telephone** | **String** | Telephone number | [optional] |
| **mobile** | **String** | Mobile number (E.164 format if passport enabled) | [optional] |
| **notes** | **String** | Additional notes | [optional] |
| **barcode** | **String** | Barcode identifier | [optional] |
| **system_id** | **String** | External system identifier | [optional] |
| **organisation_id** | **Integer** | Organisation ID | [optional] |
| **custom_1** | **String** | Custom field 1 | [optional] |
| **custom_2** | **String** | Custom field 2 | [optional] |
| **custom_3** | **String** | Custom field 3 | [optional] |
| **custom_4** | **String** | Custom field 4 | [optional] |
| **custom_5** | **String** | Custom field 5 | [optional] |
| **group_ids** | **Array&lt;Integer&gt;** | Array of group IDs to assign this person to | [optional] |
| **role_ids** | **Array&lt;Integer&gt;** | Array of role IDs to assign to this person (requires permission) | [optional] |
| **deleted** | **Boolean** | Mark person as deleted (used internally) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::PersonInput.new(
  first_name: John,
  last_name: Doe,
  salutation: null,
  job_title: null,
  email: null,
  department: null,
  enabled: null,
  valid_from: null,
  valid_to: null,
  image_base64: null,
  image_remote_url: null,
  telephone: null,
  mobile: +14155551234,
  notes: null,
  barcode: null,
  system_id: null,
  organisation_id: null,
  custom_1: null,
  custom_2: null,
  custom_3: null,
  custom_4: null,
  custom_5: null,
  group_ids: [1,3,5],
  role_ids: [2,4],
  deleted: null
)
```


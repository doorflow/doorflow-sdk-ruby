# DoorFlow::Person

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the person |  |
| **first_name** | **String** | First name (required) |  |
| **last_name** | **String** | Last name (required) |  |
| **salutation** | **String** | Salutation or title (Mr., Ms., Dr., etc.) | [optional] |
| **job_title** | **String** | Job title | [optional] |
| **email** | **String** | Email address (must be unique within account if provided) | [optional] |
| **organisation_id** | **Integer** | Organisation ID | [optional] |
| **system_id** | **String** | External system identifier | [optional] |
| **department** | **String** | Department name | [optional] |
| **enabled** | **Boolean** | Whether the person is currently enabled for access |  |
| **valid_from** | **Time** | Access valid from this date/time | [optional] |
| **valid_to** | **Time** | Access valid until this date/time | [optional] |
| **image_url** | **String** | URL to person&#39;s full-size photo | [optional] |
| **image_thumbnail_url** | **String** | URL to person&#39;s thumbnail photo | [optional] |
| **telephone** | **String** | Telephone number | [optional] |
| **mobile** | **String** | Mobile number (E.164 format required if passport enabled) | [optional] |
| **notes** | **String** | Additional notes | [optional] |
| **barcode** | **String** | Barcode identifier | [optional] |
| **custom_1** | **String** | Custom field 1 | [optional] |
| **custom_2** | **String** | Custom field 2 | [optional] |
| **custom_3** | **String** | Custom field 3 | [optional] |
| **custom_4** | **String** | Custom field 4 | [optional] |
| **custom_5** | **String** | Custom field 5 | [optional] |
| **created_at** | **Time** | Timestamp of creation | [optional] |
| **updated_at** | **Time** | Timestamp of last update | [optional] |
| **groups** | **Array&lt;Integer&gt;** | Array of group IDs this person belongs to |  |
| **roles** | **Array&lt;Integer&gt;** | Array of role IDs assigned to this person |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Person.new(
  id: 12345,
  first_name: John,
  last_name: Doe,
  salutation: Mr.,
  job_title: Software Engineer,
  email: john.doe@example.com,
  organisation_id: null,
  system_id: EMP-12345,
  department: Engineering,
  enabled: true,
  valid_from: null,
  valid_to: null,
  image_url: null,
  image_thumbnail_url: null,
  telephone: null,
  mobile: +14155551234,
  notes: null,
  barcode: null,
  custom_1: null,
  custom_2: null,
  custom_3: null,
  custom_4: null,
  custom_5: null,
  created_at: null,
  updated_at: null,
  groups: [1,3,5],
  roles: [2,4]
)
```


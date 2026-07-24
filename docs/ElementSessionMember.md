# DoorFlow::ElementSessionMember

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **external_id** | **String** | The integrator&#39;s CRM-side identifier for the person. DoorFlow stores this on &#x60;Person.organisation_id&#x60; and uses it for find-or-create on subsequent calls.  |  |
| **name** | **String** | Person&#39;s full name. Used when creating a new Person record. | [optional] |
| **email** | **String** | Person&#39;s email. Used when creating a new Person and to claim an existing unlinked Person with the same email. | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ElementSessionMember.new(
  external_id: u_42,
  name: Alice Smith,
  email: alice@example.com
)
```


# DoorFlow::ElementSessionInput

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **widget_type** | **String** | Which widget kind this session authorises. &#x60;admin&#x60; exposes credential issue/revoke and group management; &#x60;member&#x60; exposes wallet provisioning and self-deactivation.  |  |
| **member** | [**ElementSessionMember**](ElementSessionMember.md) |  |  |
| **identity_assertion** | **String** | Optional partner-signed JWT (RFC 7521 / RFC 7523) carrying verified-identity claims. When present and verified against the partner&#39;s published JWKS, downstream wallet provisioning may skip its own SMS verification step.  | [optional] |
| **platform** | **String** | Optional platform hint. Only honoured by the iOS-side &#x60;/sdk/button&#x60; host page; ignored by the JS shell.  | [optional] |
| **config** | [**ElementSessionConfig**](ElementSessionConfig.md) |  | [optional] |
| **credentials** | **Array&lt;String&gt;** | Optional explicit credential-type slugs (or well-known aliases) to expose in the widget. Defaults to all wallet-eligible types for the requested widget kind.  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ElementSessionInput.new(
  widget_type: member,
  member: null,
  identity_assertion: null,
  platform: null,
  config: null,
  credentials: [&quot;mobile_access&quot;,&quot;pin&quot;]
)
```


# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-07-24

### Added
- `Credential#status` accepts `added_to_wallet` for PassFlow credentials added to a wallet, with `wallet_type` (`apple`/`google`) — previously raised `ArgumentError` during deserialisation
- Element session support: `client.admin_sessions` / `client.member_sessions` proxies and `ElementSessionResource`
- New endpoints from the current OpenAPI spec: card designs, card templates, element sessions, admission requests, notification rules, sync

### Fixed
- `DoorFlow.api_base=` no longer drops an explicit port (e.g. `http://localhost:3000`)
- Gem is built as `doorflow` (matching the published gem name) rather than `doorflow-api`

### Removed
- Stale models no longer produced by generation: `CreateCredential422Response`, `CreateCredential422ResponseErrors`, `DeleteGroupReservation200Response`

## [1.0.0] - 2025-02-04

### Added
- Initial release of DoorFlow Ruby SDK for API v3
- OAuth 2.0 authentication with PKCE support
- Automatic token refresh with configurable buffer
- Token storage interface with `FileTokenStorage` reference implementation
- Stripe-style resource classes: Account, Channel, Credential, CredentialType, Event, Group, GroupReservation, NotificationRule, Person, Reservation, Role, Site
- Auto-pagination support with `.auto_paging_each`
- Webhook signature verification and event handling
- Full support for DoorFlow API v3 endpoints
- Comprehensive documentation and examples

### Technical
- Requires Ruby 3.2 or higher
- Built with OpenAPI Generator 7.18.0
- Uses Faraday for HTTP requests
- User-Agent: `doorflow-ruby/1.0.0`

[1.0.0]: https://github.com/doorflow/doorflow-sdk-ruby/releases/tag/v1.0.0

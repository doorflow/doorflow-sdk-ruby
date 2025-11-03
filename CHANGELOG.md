# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-03

### Added
- Initial release of DoorFlow Ruby SDK for API v3
- Stripe-style API wrapper for idiomatic Ruby usage
- Resource classes: Account, Channel, Credential, CredentialType, Event, Group, GroupReservation, NotificationRule, Person, Reservation, Role, Site
- Auto-pagination support with `.auto_paging_each`
- Full support for DoorFlow API v3 endpoints:
  - Accounts API
  - Admission Requests API
  - Channels API (door controllers)
  - Credential Types API
  - Credentials API
  - Events API
  - Group Reservations API
  - Groups API
  - Notification Rules API
  - OAuth API
  - People API
  - Reservations API
  - Roles API
  - Sites API
  - Sync API
- Comprehensive documentation and examples
- MIT License

### Technical
- Requires Ruby 3.2 or higher
- Built with OpenAPI Generator 7.18.0
- Uses Faraday for HTTP requests
- Supports OAuth2 authentication

[1.0.0]: https://github.com/doorflow/doorflow-sdk-ruby/releases/tag/v1.0.0

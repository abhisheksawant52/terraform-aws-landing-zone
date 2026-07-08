# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-07-08

### Added

- AWS multi-account landing zone: Organizations, OUs, Service Control
  Policies, hub-spoke networking (VPC + Transit Gateway), security baseline
  (GuardDuty, Config), and organization-wide logging (CloudTrail).
- Modular Terraform layout with reusable submodules under `modules/`.
- Environment-specific configuration for `dev` and `prod`.
- CI pipeline (fmt, validate, tflint), pre-commit hooks, and open-source
  project files (LICENSE, CONTRIBUTING, SECURITY, CODE_OF_CONDUCT).

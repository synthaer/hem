# HEM Profile: Hardware

<!-- Theme: hardware -->
Embedded systems, firmware, drivers, and physical device projects.

## Loads
- Base: `_base.md`
- Workflow: `workflows/sdlc-full.md`
- Agents: `agents/governance-lite.md`

## What This Covers
- Embedded firmware (ESP32, Arduino, STM32, etc.)
- Operating system drivers and kernel modules
- Boot loaders and EFI applications
- Hardware control software (Victron, solar, automotive)
- Platform-specific native applications (macOS internals, FreeBSD)
- Cryptographic hardware (FIDO2, security keys, HSMs)

## Requirements
- README.md with: target platform, build prerequisites, flashing instructions
- Datasheet references for hardware components
- Pin diagrams or wiring docs where applicable
- Platform-specific build system (Makefile, PlatformIO, cargo, etc.)

## Safety-Critical Awareness
Hardware projects can brick devices. Extra care required:
- **Never flash without backup** of current firmware/config
- **Verify target device** before any write operation
- **Document rollback procedure** before attempting changes
- **Power considerations** — know what happens if power drops mid-flash
- **Voltage and pin safety** — verify levels before connecting anything

## Build & Toolchain
- Cross-compilation is common — document host and target platforms
- Toolchain installation steps in README (arm-none-eabi-gcc, esptool, etc.)
- Binary size matters — track and document firmware size constraints
- Debug interfaces documented (JTAG, SWD, serial, USB)

## Testing
Traditional unit tests may not apply. Instead:
- Hardware-in-the-loop testing procedures
- Smoke tests on target hardware
- Regression tests for protocol compliance
- Emulator/simulator testing where available

## Git Strategy
- `feature/*`, `fix/*`, `refactor/*`
- Tag releases with hardware revision: `v1.0.0-rev2`
- Track binary artifacts separately (don't commit large binaries)

## AAKT Level: Moderate
Store: architecture decisions, protocol choices, component selection rationale,
cross-project hardware patterns (e.g., crypto patterns from fido2token reused in key-gen).
**Never store:** proprietary datasheets, hardware security keys, device serial numbers.

## Active Skills
git-automation, code-review, testing, estimation

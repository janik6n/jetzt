# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.6.6] - 2020-01-30

### Added

### Changed

### Removed

### Fixed

- Added version pinning for dependencies.

## [0.6.5] - 2019-08-17

### Added

### Changed

- Improved method of installing **pip**.

### Removed

### Fixed


## [0.6.4] - 2019-04-30

### Added

### Changed

### Removed

### Fixed

- Fixed a bug while installing a package (updating jetzt_metadata.json). The bug occured e.g. with jupyterlab which also installs jupyterlab-server as a dependency. Thus, the package name failed to resolve while validating installation.
- Tweaked README.

## [0.6.3] - 2019-04-16

### Added

### Changed

### Removed

### Fixed

- Python dependencies with "-" in package name, such as `python-dateutil` now works in installs and removes.


## [0.6.2] - 2019-04-15

### Added

### Changed

### Removed

### Fixed

- Improved terminal color handling on Linux (tested on Fedora 29 and Ubuntu 18.04).

## [0.6.1] - 2019-04-14

### Added

### Changed

### Removed

### Fixed

- Fixed a bug in `jetzt --reinstall`. The dependency version is now pinned temporarily for installation.


## [0.6.0] - 2019-04-14

### Added

- Added ability to reinstall all dependencies (excluding editable), with `jetzt --reinstall`.

### Changed

### Removed

### Fixed

## [0.5.0] - 2019-04-14

### Added

- Added ability to remove dependencies, with `jetzt --remove`.
- Added ability to generate standard `requirements.txt` and `requirements-dev.txt` based on `jetzt_metadata.json`, with `jetzt --create-requirements`.

### Changed

### Removed

### Fixed


## [0.4.1] - 2019-04-13

### Added

### Changed

### Removed

### Fixed

- Fixed a crash while listing outdated dependencies.


## [0.4.0] - 2019-04-13

### Added

- Added ability to update outdated dependencies, with `jetzt --update`. This will list all the outdated dependencies based on command `jetzt --outdated`.

### Changed

### Removed

### Fixed

- Listing of outdated dependencies now distinguishes `dependencies` from `dev_dependencies`.


## [0.3.1] - 2019-04-12

### Added

### Changed

### Removed

- A couple of debug prints were removed.

### Fixed

## [0.3.0] - 2019-04-12

### Added

- A new `jetzt_metadata.json` is introduced. This file will be used to maintain project metadata including installed dependencies. **UNFORTUNATELY THIS INTRODUCES BREAKING CHANGES**. You need to scaffold a new project, install dependencies again, and finally move your code manually from prior projects.
- Ability to list outdated dependencies. The ability to actually install the updates is coming soon.

### Changed

- Jetzt is no longer depending on `requirements.txt` and `requirements-dev.txt` for dependency management, `jetzt_metadata.json` is used instead.

### Removed

### Fixed


## [0.2.1] - 2019-04-12

### Added

### Changed

### Removed

### Fixed

- Version pinning works for package installation.
- Package installation errors are not catched correctly.

## [0.2.0] - 2019-04-09

### Added

- Added ability to scaffold a new project to any folder. Environment variable `JETZT_HOME` is no longer needed.

### Changed

### Removed

### Fixed


## [0.1.1] - 2019-03-05

### Added

- Changelog added.

### Changed

### Removed

### Fixed

- Jetzt was missing from created project, so installations did not work.
- Running jetzt without command caused an error.


## [0.1.0] - 2019-03-05

### Added

- Initial functionality to scaffold a project, and to install and list packages.

### Changed

### Removed

### Fixed

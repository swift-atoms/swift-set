# Set

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-atoms/swift-set/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-atoms/swift-set/actions/workflows/ci.yml)

The minimal set atom: a `Membership` contract for hashable elements and an ownership-neutral `__Set<Store>` carrier for extracted storage seams. `Membership` standardizes `contains`, a `Cardinal` count, and the derived `isEmpty` property without choosing storage, ordering, allocation, or mutation policy.

---

## Key Features

- **Membership vocabulary** — `contains`, `count`, and derived `isEmpty` for any set discipline.
- **Canonical value domains** — elements conform to `Hash.Protocol`; counts use `Cardinal`.
- **Storage-neutral carrier** — `__Set<Store>` owns an arbitrary store and can hand it back through consuming `take()`.
- **Ownership propagation** — the carrier is `Copyable` and `Sendable` exactly when its store is.

---

## Quick Start

```swift
import Set

struct UserID: Hash.Protocol {
    let rawValue: Int

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

struct Users: Membership {
    let values: [UserID]

    func contains(_ element: borrowing UserID) -> Bool {
        values.contains(element)
    }

    var count: Cardinal { Cardinal(UInt(values.count)) }
}

let users = Users(values: [UserID(rawValue: 1), UserID(rawValue: 2)])
users.contains(UserID(rawValue: 2))  // true
users.count                          // Cardinal(2)
users.isEmpty                        // false
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-set.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Set", package: "swift-set")
    ]
)
```

The package is pre-1.0 — depend on `branch: "main"` until `0.1.0` is tagged. Requires Swift 6.4 and macOS 27 / iOS 27 / tvOS 27 / watchOS 27 / visionOS 27 (or the corresponding Linux / Windows toolchain).

---

## Architecture

| Product | Contents | When to import |
|---------|----------|----------------|
| `Set` | `Membership`, its `isEmpty` default, and the generic `__Set<Store>` carrier; re-exports `Hash` and `Cardinal` | Production consumers and set-discipline authors |
| `Set Apple Foundation Integration` | Re-exports `Set` alongside Foundation | Apple-platform integration targets |
| `Set Test Support` | Re-exports `Set` plus Hash and Cardinal standard-library integrations | Test targets |

Foundation is confined to `Set Apple Foundation Integration`; the core and Test Support targets are Foundation-free.

---

## Platform Support

| Platform         | CI  | Status       |
|------------------|-----|--------------|
| macOS 27         | Yes | Full support |
| Linux            | Yes | Full support |
| Windows          | Yes | Full support |
| iOS/tvOS/watchOS | —   | Supported    |
| Swift Embedded   | —   | Targeted     |

---

## Related Packages

- [`swift-hash`](https://github.com/swift-atoms/swift-hash) — the element hashing contract used by `Membership`.
- [`swift-cardinal`](https://github.com/swift-atoms/swift-cardinal) — the nonnegative count domain exposed by `Membership`.

---

## Community

<!-- BEGIN: discussion -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).

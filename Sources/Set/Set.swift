@_documentation(visibility: public)
@frozen
public struct __Set<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var store: S

    @inlinable
    public init(store: consuming S) {
        self.store = store
    }

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __Set: Copyable where S: Copyable {}

extension __Set: Sendable where S: Sendable & ~Copyable {}

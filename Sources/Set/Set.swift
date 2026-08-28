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
    public func withStore<R, Failure: Swift.Error>(
        _ body: (borrowing S) throws(Failure) -> R
    ) throws(Failure) -> R {
        try body(store)
    }

    @inlinable
    public mutating func withMutableStore<R, Failure: Swift.Error>(
        _ body: (inout S) throws(Failure) -> R
    ) throws(Failure) -> R {
        try body(&store)
    }

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __Set: Copyable where S: Copyable {}

extension __Set: Sendable where S: Sendable & ~Copyable {}

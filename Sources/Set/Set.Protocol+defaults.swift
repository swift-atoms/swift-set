public import Cardinal

extension Membership where Self: ~Copyable {

    @inlinable
    public var isEmpty: Bool { count == Cardinal(0) }
}

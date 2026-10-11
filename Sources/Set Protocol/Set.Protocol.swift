public import Index
import Set_Primitive

public protocol Membership: ~Copyable {

    associatedtype Element: Swift::Hashable & ~Copyable

    func contains(_ element: borrowing Element) -> Bool

    var count: Index<Element>.Count { get }
}

public typealias __SetProtocol = Membership

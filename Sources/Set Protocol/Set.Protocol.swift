public import Hash
public import Index
import Set_Primitive

public protocol Membership: ~Copyable {

    associatedtype Element: Hash.`Protocol` & ~Copyable

    func contains(_ element: borrowing Element) -> Bool

    var count: Index<Element>.Count { get }
}

public typealias __SetProtocol = Membership

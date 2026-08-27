public import Cardinal
public import Hash

public protocol Membership: ~Copyable {

    associatedtype Element: Hash.`Protocol` & ~Copyable

    func contains(_ element: borrowing Element) -> Bool

    var count: Cardinal { get }
}

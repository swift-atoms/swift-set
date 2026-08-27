public import Index
public import Set_Primitive
public import Store_Protocol

extension __Set where S: Store.`Protocol` & ~Copyable {

    public typealias Index = Index.Index<S.Element>
}

public import Index
public import Set_Primitive
public import Store

extension __Set where S: Store.`Protocol` & ~Copyable {

    public typealias Index = Index.Index<S.Element>
}

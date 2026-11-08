public import Index
public import Set_Primitive
public import Store

public typealias __SetStorageIndex<Element: ~Copyable> = Index::Index<Element>

extension __Set where S: Store.`Protocol` & ~Copyable {

    public typealias Index = __SetStorageIndex<S.Element>
}

public import Buffer
public import Buffer_Linear_Primitive
public import Hash_Indexed_Primitive
public import Hash_Table_Primitive
public import Memory
public import Memory_Allocator
public import Storage

public typealias Set<E: Swift::Hashable & ~Copyable> =
    __Set<Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>>

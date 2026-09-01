public import Buffer_Linear_Primitive
public import Buffer_Primitive
public import Hash_Indexed_Primitive
public import Memory_Allocator_Primitive
public import Memory
public import Storage_Contiguous
public import Storage_Primitive

public typealias Set<E: Hash.Key & ~Copyable> =
    __Set<Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>>

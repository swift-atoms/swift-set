public import Buffer_Linear_Primitive
public import Buffer
public import Hash_Indexed_Primitive
public import Memory_Allocator
public import Memory
public import Storage

public typealias Set<E: Hash.Key & ~Copyable> =
    __Set<Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>>

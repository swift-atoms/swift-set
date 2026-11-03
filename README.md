# swift-set

Use this package when you need a hash set of unique members, including `~Copyable` members, and only ask whether a member is present, add or remove it, or visit every member. Start from `Set<E>`, which stores members directly in one owned column. Use `__Set<Ownership.Shared<E, Hash.Indexed<…>>>` instead when copies of the set must share storage until one of them changes. To write code that works for any membership container, take a `Membership`. When you need to look up a member's position, or need the first or last member or a hashable set, use the swift-set-ordered package instead. For a dense set of small integers, use swift-bitset.

## Laws

- Members are kept in insertion order. `forEach` visits them in that order. Growing the set does not change it, and removing a member leaves the others in the same relative order.
- If `insert` gets a member equal to one already stored, it keeps the stored member and hands the argument back to the caller. It returns `nil` only when the member was added.
- `remove` returns the stored member, or `nil` when no equal member is present.
- Two members are the same member when `==` says so, even if their hashes collide with other members.
- In the shared form, copies share one store. `insert` and `remove` first give the copy being changed a store of its own, so other copies are never affected. `contains`, `forEach` and `count` never copy the store.
- In the shared form, `removeAll` always swaps in a fresh store and never empties the shared one in place. With `keepingCapacity`, the fresh store is created with at least the old capacity.
- `clone()` always returns a set with its own store. For a copyable store, `unshare()` is called on the new set only, never on the original.
- Every member is deinitialized exactly once. That covers members removed or cleared from the set, members still in the set when its last copy goes away, and duplicates handed back by `insert` (the caller owns those).

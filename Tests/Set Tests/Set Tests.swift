import Set_Test_Support
import Testing

private struct Members: Membership {
    let elements: Swift.Set<Int>

    func contains(_ element: borrowing Int) -> Bool {
        elements.contains(element)
    }

    var count: Cardinal { Cardinal(UInt(elements.count)) }
}

@Suite
struct `Set Tests` {

    @Test
    func `the generic set core wraps and hands back its store`() {
        let set = __Set(store: 7)
        let store = set.take()
        #expect(store == 7)
    }

    @Test
    func `the generic set core lends its store to integrations`() {
        var set = __Set(store: 7)

        let original = set.withStore { $0 }
        set.withMutableStore { $0 = 11 }
        let updated = set.withStore { $0 }

        #expect(original == 7)
        #expect(updated == 11)
    }

    @Test
    func `membership exposes containment and cardinal count`() {
        let members = Members(elements: [2, 3, 5])

        #expect(members.contains(3))
        #expect(!members.contains(4))
        #expect(members.count == 3)
        #expect(!members.isEmpty)
    }

    @Test
    func `empty membership derives isEmpty`() {
        let members = Members(elements: [])

        #expect(members.count == 0)
        #expect(members.isEmpty)
    }
}

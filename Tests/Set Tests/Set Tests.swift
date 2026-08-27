import Set
import Testing

@Suite
struct `Set Tests` {

    @Test
    func `the generic set core wraps and hands back its store`() {
        let set = __Set(store: 7)
        let store = set.take()
        #expect(store == 7)
    }
}

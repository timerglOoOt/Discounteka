import XCTest
@testable import Discount

final class DiscountTests: XCTestCase {
    private let viewModel = MainViewModel()
    private let mockDelegate = MockMainViewOutput()

    override func setUp() {
        super.setUp()
        viewModel.delegate = mockDelegate

        CardService.shared.cards = [
            Card(type: .qr, name: "Test1", code: "1"),
            Card(type: .qr, name: "Test2", code: "2")
        ]
    }

    func testNumberOfRowsInSection() {
        let rowCount = viewModel.numberOfRowsInSection()
        XCTAssertEqual(rowCount, 2, "Кол-во строк должно совпадать с кол-вом кард")
    }

    func testConfigureCell() {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        let indexPath = IndexPath(row: 0, section: 0)

        let cell = viewModel.configureCell(tableView, cellForRowAt: indexPath)

        XCTAssertTrue(cell is MainTableViewCell, "Ячейка должна быть типа MainTableViewCell")
    }

    func testSaveCard() {
        let card = Card(type: .qr, name: "Test3", code: "3")
        CardService.shared.saveCard(card)
        XCTAssert(
            CardService.shared.cards.contains { $0.name == card.name && $0.code == card.code },
            "Карта должна корректно добавляться в массив"
        )
    }

    func testCleanCards() {
        CardService.shared.cleanCards()
        XCTAssert(CardService.shared.cards.isEmpty, "Все карты должны были удалиться")
    }

    func testShowAboutAppController() {
        viewModel.showAboutAppController()

        XCTAssertTrue(mockDelegate.didShowAboutAppController, "Делегат должен вызывать showAboutAppController")
    }

    func testShowNewCardController() {
        viewModel.showNewCardController()

        XCTAssertTrue(mockDelegate.didShowNewCardController, "Делегат должен вызывать showNewCardController")
    }
}

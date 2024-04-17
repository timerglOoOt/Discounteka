import UIKit
import SnapKit

// MARK: Вид главного экрана

protocol MainSceneDelegate: AnyObject {
    func addButtonTapped()
}

class MainView: UIView {
    private lazy var cardsTableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.rowHeight = 60
        table.bounces = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var addButton: UICustomButton = {
        let button = UICustomButton("Добавить", "plus.circle")
        button.addAction(UIAction(handler: { _ in
            self.delegate?.addButtonTapped()
        }), for: .touchUpInside)
        return button
    }()

    weak var delegate: MainSceneDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Работа с положением элементов на MainView

extension MainView {
    func setupLayout() {
        backgroundColor = .white

        addSubview(cardsTableView)
        addSubview(addButton)

        cardsTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-100)
        }

        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(65)
            make.width.equalTo(350)
        }

    }
}

// MARK: Работа с данными

extension MainView {
    func setupDataSource(_ dataSource: UITableViewDataSource) {
        cardsTableView.dataSource = dataSource
    }

    func setupDelegate(_ delegate: UITableViewDelegate) {
        cardsTableView.delegate = delegate
    }
}

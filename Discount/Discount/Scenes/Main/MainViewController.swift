import UIKit
import Combine

class MainViewController: UIViewController {
    private let mainView = MainView(frame: .zero)
    var viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    var cardsCount = 0

    override func loadView() {
        super.loadView()

        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupBindigs()
        mainView.delegate = self
        mainView.setupDataSource(self)
        mainView.setupDelegate(self)
        viewModel.controller = self
    }

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Настройка таблицы + делегата кнопки

extension MainViewController: MainSceneDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        viewModel.deleteByLeftSwipe(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateSelectedRow(tableView, didSelectRowAt: indexPath)
    }

    func addButtonTapped() {
        viewModel.showNewCardController()
    }

    func setupBindigs() {
        CardService.shared.$cards
        .sink { [weak self] cards in
            let curCardsCount = cards.count
            if curCardsCount != self?.cardsCount {
                DispatchQueue.main.async {
                    self?.mainView.reloadData()
                }
            }
            self?.cardsCount = curCardsCount
        }
        .store(in: &cancellables)
    }
}

// MARK: Настройка NavigationBar

extension MainViewController {
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(handleTap))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "textColor")

        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "  Мои карты"
            label.textColor = UIColor(named: "textColor")
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            return label
        }()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    @objc private func handleTap() {
        viewModel.showAboutAppController()
    }
}

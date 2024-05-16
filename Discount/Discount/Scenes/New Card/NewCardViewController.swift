import UIKit
import Combine
import SwiftUI
import SnapKit
import CodeScanner

class NewCardViewController: UIViewController {
    private let newCardView = NewCardView(frame: .zero)
    let viewModel: NewCardViewModel
    private var cancellable: AnyCancellable?
    var scanView = ScannerView()

    override func loadView() {
        view = newCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        newCardView.delegate = self
        setupNavigationBar()
        setupBindigs()
        scanView.delegate = self
    }

    init(viewModel: NewCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewCardViewController {
    private func setupNavigationBar() {
        let item = UICustomBackItem(titleLabel: "Карта с QR-кодом")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        item.addGestureRecognizer(tapGesture)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: item)
    }

    @objc func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension NewCardViewController: ScannerViewProtocol {
    func didResultChanged(result: Result<CodeScanner.ScanResult, CodeScanner.ScanError>) {
        switch result {
        case .success(let text):
            self.newCardView.cardNumberCustomTextField.text = text.string
        case .failure(let message):
            print(message.localizedDescription)
        }
    }
}

extension NewCardViewController: NewCardSceneDelegate {
    func setupBindigs() {    }

    func saveButtonTapped() {
        let cardInfo = newCardView.getTextFields()
        viewModel.addNewCard(cardValue: cardInfo.0, cardName: cardInfo.1, cardType: .withQR)
        navigationController?.popViewController(animated: true)
    }

    func scanButtonTapped() {
        configScannerView()
    }

    private func configScannerView() {
        let hostingController = UIHostingController(rootView: scanView)
        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        hostingController.didMove(toParent: self)
    }
}

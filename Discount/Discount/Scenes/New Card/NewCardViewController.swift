import UIKit
import Combine
import SwiftUI
import SnapKit
import CodeScanner
import AVFoundation

class NewCardViewController: UIViewController {
    private let newCardView = NewCardView(frame: .zero)
    let viewModel: NewCardViewModel
    private var cancellable: AnyCancellable?
    private var scanView = ScannerView()
    private var hostingController: UIHostingController<ScannerView>?
    var cardType: AVMetadataObject.ObjectType?

    override func loadView() {
        view = newCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        newCardView.delegate = self
        setupNavigationBar()
        setupBindigs()
        scanView.delegate = self
        viewModel.controller = self
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
        let titleLabel = "Card with".localized() + (cardType == .qr ? " QR code".localized() : " barcode".localized())
        let item = UICustomBackItem(titleLabel: titleLabel)

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
    func dismissScanner() {
        hostingController?.willMove(toParent: nil)
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        hostingController = nil
        navigationController?.dismiss(animated: true)
    }

    func didResultChanged(result: Result<CodeScanner.ScanResult, CodeScanner.ScanError>) {
        switch result {
        case .success(let text):
            self.newCardView.cardNumberCustomTextField.text = text.string
            self.cardType = text.type
        case .failure(let message):
            print(message.localizedDescription)
        }

        if let hostingController = children.last as? UIHostingController<ScannerView> {
            hostingController.willMove(toParent: nil)
            hostingController.view.removeFromSuperview()
            hostingController.removeFromParent()
        }
    }
}

extension NewCardViewController: NewCardSceneDelegate {
    func setupBindigs() {}

    func saveButtonTapped() {
        if newCardView.checkIfTextFieldsIsEmpty() {
            self.showAlert(
                title: "Error".localized(),
                message: "You are trying to send an empty field! Please enter the text.".localized()
            )
            return
        }
        let cardInfo = newCardView.getTextFields()
        viewModel.addNewCard(cardValue: cardInfo.0, cardName: cardInfo.1, cardType: cardType ?? .qr)
        if let viewControllers = self.navigationController?.viewControllers {
            if viewControllers.count >= 3 {
                let targetViewController = viewControllers[viewControllers.count - 3]
                self.navigationController?.popToViewController(targetViewController, animated: true)
            }
        }

    }

    func scanButtonTapped() {
        configScannerView()
    }

    private func configScannerView() {
        hostingController = UIHostingController(rootView: scanView)
        if let hostingController = hostingController {
            addChild(hostingController)
            view.addSubview(hostingController.view)

            hostingController.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            hostingController.didMove(toParent: self)
        }
    }
}

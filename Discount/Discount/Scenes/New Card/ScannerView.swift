import SwiftUI
import CodeScanner
import Combine

protocol ScannerViewProtocol {
    func didResultChanged(result: Result<ScanResult, ScanError>)
}

struct ScannerView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    var delegate: ScannerViewProtocol?

    var body: some View {
        sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr, .ean13, .upce, .code128,
                                        .code39, .code93, .code39Mod43,
                                        .interleaved2of5], simulatedData: "ibb"
            ) { response in
                delegate?.didResultChanged(result: response)
            }
        }
    }
}

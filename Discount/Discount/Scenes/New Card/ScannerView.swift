import SwiftUI
import CodeScanner

protocol ScannerViewProtocol {
    func didResultChanged(result: Result<ScanResult, ScanError>)
    func dismissScanner()
}

struct ScannerView: View {
    @State private var isPresentingScanner = true
    var delegate: ScannerViewProtocol?

    var body: some View {
        ZStack {
            if isPresentingScanner {
                CodeScannerView(codeTypes: [.qr, .code128, .microQR], simulatedData: "some card"
                ) { response in
                    delegate?.didResultChanged(result: response)
                    isPresentingScanner = false
                    delegate?.dismissScanner()
                }
                .edgesIgnoringSafeArea(.all)
                .gesture(DragGesture().onEnded { value in
                    if value.translation.width > 100 {
                        isPresentingScanner = false
                        delegate?.dismissScanner()
                    }
                })
            }

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresentingScanner = false
                        delegate?.dismissScanner()
                    }) {
                        Text(Strings.close)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}

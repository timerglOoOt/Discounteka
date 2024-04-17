import UIKit

class MainViewModel {
    private var cards: [Type] = [
        CardWithQR(name: "Магнит", qrcode: UIImageView(image: UIImage(named: "mockqr"))),
        CardWithBarcode(name: "Discontus", barcode: UIImageView(image: UIImage(named: "mockbarcode")))
    ]

    func numberOfRowsInSection() -> Int {
        cards.count
    }

    func getHeight(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        switch cards[indexPath.row].type {
        case .withQR:
            height = cards[indexPath.row].isClicked ? 240 : 60
        case .withBarcode:
            height = cards[indexPath.row].isClicked ? 170 : 60
        }
        return height
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let card = cards[indexPath.row]

        switch card.type {
        case .withBarcode:
            guard let card = card as? CardWithBarcode else { return UITableViewCell() }
            cell.configureCardWithBarcodeCell(card: card)
        case .withQR:
            guard let card = card as? CardWithQR else { return UITableViewCell() }
            cell.configureCardWithQRCell(card: card)
        }
        return cell
    }

    func updateSelectedRow(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cards[indexPath.row].isClicked.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func deleteByLeftSwipe(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            self?.cards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

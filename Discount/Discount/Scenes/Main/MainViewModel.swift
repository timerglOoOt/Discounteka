import UIKit

class MainViewModel {
    private var cardsService = CardService.shared

    func numberOfRowsInSection() -> Int {
        cardsService.getCount()
    }

//    func getHeight(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height: CGFloat
//        switch cardsService.getTask(at: indexPath.row).type {
//        case .withQR:
//            height = cardsService.getTask(at: indexPath.row).isClicked ? 240 : 60
//        case .withBarcode:
//            height = cardsService.getTask(at: indexPath.row).isClicked ? 170 : 60
//        }
//        return height
//    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let card = cardsService.getTask(at: indexPath.row)
        cell.configureCell(card: card)
        return cell
    }

    func updateSelectedRow(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardsService.toggleCardVision(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func deleteByLeftSwipe(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            self?.cardsService.removeTask(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .left)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

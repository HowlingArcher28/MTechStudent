import SwiftUI
import Combine

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()

    func goToEnhance(image: UIImage) {
        path.append(Screen.enhanceView(image: image))
    }

    func goToPerfectFit(image: UIImage) {
        path.append(Screen.perfectFitView(image: image))
    }

    func goBack() {
        path.removeLast()
    }

    func reset() {
        path = NavigationPath()
    }
}

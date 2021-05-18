import PlaygroundSupport
import SwiftUI

basedData()

public func host() {
    let host = UIHostingController(rootView: MenuView())
    host.preferredContentSize = CGSize(width: 414  , height: 896)
    PlaygroundPage.current.liveView = host
}

host()

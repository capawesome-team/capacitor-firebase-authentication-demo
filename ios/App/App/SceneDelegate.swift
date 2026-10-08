import UIKit
import Capacitor
#if RGCFA_INCLUDE_FACEBOOK
import FBSDKCoreKit
#endif

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = CAPBridgeViewController()
        window?.makeKeyAndVisible()

        SceneDelegateProxy.shared.scene(scene, willConnectTo: session, options: connectionOptions)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
#if RGCFA_INCLUDE_FACEBOOK
        let unhandledURLContexts = URLContexts.filter { context in
            !ApplicationDelegate.shared.application(
                UIApplication.shared,
                open: context.url,
                sourceApplication: context.options.sourceApplication,
                annotation: context.options.annotation
            )
        }
        if !unhandledURLContexts.isEmpty {
            SceneDelegateProxy.shared.scene(scene, openURLContexts: unhandledURLContexts)
        }
#else
        SceneDelegateProxy.shared.scene(scene, openURLContexts: URLContexts)
#endif
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        SceneDelegateProxy.shared.scene(scene, continue: userActivity)
    }
}

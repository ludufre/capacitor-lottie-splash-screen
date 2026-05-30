//
//  LottieSplashScreen.swift
//  LottieSplashScreenPlugin
//
//  @description Native Swift logic for showing and hiding a Lottie-based splash screen overlay.
//

import Foundation
import Lottie
import UIKit
import Capacitor

/// Enumeration for supported animation lifecycle events
@objc public enum AnimationEventListener: Int {
    case onAnimationEnd
}

extension AnimationEventListener {
    /// JavaScript-friendly event string
    var listenerEvent: String {
        switch self {
        case .onAnimationEnd:
            return "onAnimationEnd"
        }
    }
}

/// Core controller class for managing the Lottie splash screen lifecycle
@objc public class LottieSplashScreen: NSObject {

    // MARK: - Internal State

    private var animationView: LottieAnimationView?
    private var isAppLoaded = false
    private var isAnimationEnded = !LottieSplashScreenPlugin.isEnabledStatic
    private var autoHide = false
    private var loopMode = LottieLoopMode.playOnce

    // Store parameters to allow re-showing the splash screen
    private var backgroundView: UIView?
    private var containerView: UIView?
    private var lottiePath: String?
    private var backgroundColor: UIColor?

    private var lottiePathLight: String?
    private var lottiePathDark: String?
    private var backgroundColorLight: UIColor?
    private var backgroundColorDark: UIColor?

    public typealias AnimationEventListenerCallback = (AnimationEventListener) -> Void

    @objc public var onAnimationEvent: AnimationEventListenerCallback?

    // MARK: - Public API

    /// Check whether the splash animation is currently active
    public func isAnimating() -> Bool {
        return !isAnimationEnded
    }

    /// Notify the plugin that the app has fully loaded
    func onAppLoaded() {
        isAppLoaded = true
        if isAnimationEnded || loopMode == .loop {
            hideSplashScreen()
        }
    }

    /// Configure the splash screen with necessary parameters
    @objc public func configure(
        containerView: UIView,
        animationLight: String,
        animationDark: String?,
        backgroundLightHex: String,
        backgroundDarkHex: String?,
        autoHide: Bool,
        loop: Bool
    ) {
        self.containerView = containerView
        self.lottiePathLight = animationLight
        self.lottiePathDark = animationDark
        self.backgroundColorLight = Self.color(fromHex: backgroundLightHex)
        self.backgroundColorDark = backgroundDarkHex != nil ? Self.color(fromHex: backgroundDarkHex!) : nil
        self.autoHide = autoHide
        self.loopMode = loop ? .loop : .playOnce
    }

    /// Hide the splash screen immediately
    @objc public func hide() {
        hideSplashScreen()
    }

    /// Show the splash screen with optional animation override and without dark mode override
    @objc public func show(animationOverride: String?) {
        self.show(animationOverride: animationOverride, isDarkModeOverride: nil)
    }

    /// Show the splash screen with optional animation and dark mode overrides
    @objc public func show(animationOverride: String?, isDarkModeOverride: NSNumber?) {
        DispatchQueue.main.async {
            let useDarkMode = isDarkModeOverride?.boolValue ?? self.isSystemDarkMode()

            var selectedPath: String?
            var selectedBackgroundColor: UIColor?

            if let override = animationOverride, !override.isEmpty {
                selectedPath = override
                selectedBackgroundColor = useDarkMode ? (self.backgroundColorDark ?? self.backgroundColorLight) : self.backgroundColorLight
            } else {
                if useDarkMode, let darkPath = self.lottiePathDark, !darkPath.isEmpty {
                    selectedPath = darkPath
                    selectedBackgroundColor = self.backgroundColorDark
                } else {
                    selectedPath = self.lottiePathLight
                    selectedBackgroundColor = self.backgroundColorLight
                }
            }

            guard let containerView = self.containerView,
                  let path = selectedPath,
                  let filename = path.components(separatedBy: ".").first else {
                return
            }

            self.lottiePath = path
            self.backgroundColor = selectedBackgroundColor

            self.isAnimationEnded = false

            // Set up background
            self.backgroundView = UIView()
            self.backgroundView!.backgroundColor = self.backgroundColor
            self.backgroundView!.frame = UIScreen.main.bounds
            containerView.addSubview(self.backgroundView!)

            // Set up Lottie animation
            self.animationView = .init(name: filename)
            self.animationView!.frame = UIScreen.main.bounds
            self.animationView!.contentMode = .scaleAspectFit
            self.animationView!.loopMode = self.loopMode
            self.animationView!.animationSpeed = 1
            self.animationView!.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundView!.addSubview(self.animationView!)

            NSLayoutConstraint.activate([
                self.animationView!.widthAnchor.constraint(equalTo: self.backgroundView!.widthAnchor),
                self.animationView!.heightAnchor.constraint(equalTo: self.backgroundView!.heightAnchor)
            ])

            self.animationView!.play { completed in
                if completed || (!completed && self.loopMode == .loop) {
                    self.isAnimationEnded = true
                    self.onAnimationEvent?(.onAnimationEnd)
                    if self.isAppLoaded || self.autoHide {
                        self.hideSplashScreen()
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    private func hideSplashScreen() {
        log("Hiding splash screen")
        DispatchQueue.main.async {
            self.animationView?.removeFromSuperview()
            self.backgroundView?.removeFromSuperview()
        }
    }

    private func isSystemDarkMode() -> Bool {
        if #available(iOS 13.0, *), UITraitCollection.current.userInterfaceStyle == .dark {
            log("Dark mode detected. Using dark animation and color")
            return true
        }
        return false
    }

    private static func color(fromHex hex: String) -> UIColor {
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexColor.hasPrefix("#") { hexColor.removeFirst() }
        guard hexColor.count == 6, let rgb = Int(hexColor, radix: 16) else { return .white }
        return UIColor(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}

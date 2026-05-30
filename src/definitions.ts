/**
 * @file definitions.ts
 * @description TypeScript type definitions for the LottieSplashScreen Capacitor plugin.
 */

import type { PluginListenerHandle } from '@capacitor/core';

/**
 * @interface LottieSplashScreenPlugin
 * @description Defines the native methods and event listeners provided by the LottieSplashScreen plugin.
 *
 * This plugin allows developers to show animated Lottie-based splash screens during app startup.
 */
export interface LottieSplashScreenPlugin {
  /**
   * Notify the plugin that the app has fully loaded.
   *
   * Call this method as early as possible after your app has bootstrapped.
   * It allows the plugin to gracefully finish or remove the splash animation overlay.
   * If the splash is configured to loop, this will forcibly stop it.
   *
   * @example
   * ```ts
   * LottieSplashScreen.appLoaded();
   * ```
   *
   * @since 7.0.0
   */
  appLoaded(): void;

  /**
   * Programmatically show the splash screen animation again.
   *
   * This is useful for scenarios like restarting the splash for a specific action or navigation flow.
   *
   * @example
   * ```ts
   * LottieSplashScreen.show();
   * ```
   *
   * @since 7.0.0
   */
  show(options?: LottieSplashScreenShowOptions): void;

  /**
   * Hide the splash screen immediately, skipping the animation completion.
   *
   * Use this when you want to forcefully remove the splash overlay (e.g., on error or timeout).
   *
   * @example
   * ```ts
   * LottieSplashScreen.hide();
   * ```
   *
   * @since 7.0.0
   */
  hide(): void;

  /**
   * Check if the splash animation is currently running.
   *
   * Returns a boolean wrapped in a promise indicating the splash screen’s active state.
   *
   * @returns A promise resolving to an object: `{ isAnimating: boolean }`
   *
   * @example
   * ```ts
   * const { isAnimating } = await LottieSplashScreen.isAnimating();
   * console.log(isAnimating); // true or false
   * ```
   *
   * @since 7.0.0
   */
  isAnimating(): Promise<{ isAnimating: boolean }>;

  /**
   * Register a listener for the splash animation end event.
   *
   * This event is triggered once the animation finishes and the overlay is removed.
   *
   * @param eventName - Must be `'onAnimationEnd'`
   * @param listenerFunc - A callback function that runs when the animation completes.
   * @returns A promise resolving to a `PluginListenerHandle` for removing the listener if needed.
   *
   * @example
   * ```ts
   * const handle = await LottieSplashScreen.addListener('onAnimationEnd', () => {
   *   console.log('Splash animation finished');
   * });
   * ```
   *
   * @since 7.0.0
   */
  addListener(eventName: 'onAnimationEnd', listenerFunc: () => void): Promise<PluginListenerHandle>;
}
/**
 * Options for showing the Lottie splash screen animation programmatically.
 *
 * @param animation The path to the lottie file.
 * @param isDarkMode Optional flag to indicate if dark mode styling from capacitor.config should be applied.
 *
 * @example
 * ```ts
 * const options: LottieSplashScreenShowOptions = {
 *   animation: 'public/assets/lottie-runtime.json',
 *   isDarkMode: true
 * };
 * LottieSplashScreen.show(options);
 * ```
 *
 * @since 7.3.0
 */
export interface LottieSplashScreenShowOptions {
  animation: string;
  isDarkMode?: boolean;
}

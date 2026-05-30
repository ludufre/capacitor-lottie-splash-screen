/**
 * @file index.ts
 * @description Entry point for the LottieSplashScreen plugin.
 * This file defines the plugin's registration and export interfaces for all platforms.
 */

import { registerPlugin } from '@capacitor/core';
import type { LottieSplashScreenPlugin } from './definitions';

/**
 * Registers the `LottieSplashScreen` plugin.
 *
 * - The plugin name `LottieSplashScreen` is used to bridge native implementations with the JavaScript runtime.
 * - On web, a stub implementation is dynamically imported to prevent runtime errors during PWA or dev server use.
 *
 */
const LottieSplashScreen = registerPlugin<LottieSplashScreenPlugin>('LottieSplashScreen', {
  /**
   * Dynamic import of the web fallback implementation.
   * Used only in browser environments where native plugins are not available.
   *
   * @returns A Promise that resolves to the `LottieSplashScreenWeb` implementation.
   */
  web: () => import('./web').then((m) => new m.LottieSplashScreenWeb()),
});

/**
 * Re-export plugin definitions for external TypeScript consumers.
 * This allows direct access to the `LottieSplashScreenPlugin` interface.
 */
export * from './definitions';

/**
 * Exports the registered plugin instance.
 * Users can call methods like `LottieSplashScreen.show()` from their app code.
 */
export { LottieSplashScreen };

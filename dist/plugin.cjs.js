'use strict';

var core = require('@capacitor/core');

/**
 * @file index.ts
 * @description Entry point for the LottieSplashScreen plugin.
 * This file defines the plugin's registration and export interfaces for all platforms.
 */
/**
 * Registers the `LottieSplashScreen` plugin.
 *
 * - The plugin name `LottieSplashScreen` is used to bridge native implementations with the JavaScript runtime.
 * - On web, a stub implementation is dynamically imported to prevent runtime errors during PWA or dev server use.
 *
 */
const LottieSplashScreen = core.registerPlugin('LottieSplashScreen', {
    /**
     * Dynamic import of the web fallback implementation.
     * Used only in browser environments where native plugins are not available.
     *
     * @returns A Promise that resolves to the `LottieSplashScreenWeb` implementation.
     */
    web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.LottieSplashScreenWeb()),
});

/**
 * @file web.ts
 * @description Web implementation of the LottieSplashScreen plugin.
 * This implementation is non-functional and serves as a fallback for web platforms.
 */
/**
 * @class LottieSplashScreenWeb
 * @extends WebPlugin
 * @implements LottieSplashScreenPlugin
 *
 * Stub implementation for the web. All methods are either no-ops or throw unimplemented exceptions.
 *
 */
class LottieSplashScreenWeb extends core.WebPlugin {
    /**
     * Show the splash screen (not implemented on web).
     */
    async show() {
        console.warn('LottieSplashScreen show() is not supported on web.');
        return Promise.resolve();
        // throw this.createUnimplementedError();
    }
    /**
     * Hide the splash screen (not implemented on web).
     */
    async hide() {
        console.warn('LottieSplashScreen hide() is not supported on web.');
        return Promise.resolve();
        // throw this.createUnimplementedError();
    }
    /**
     * Notify that the app has loaded (not implemented on web).
     */
    async appLoaded() {
        console.warn('LottieSplashScreen appLoaded() is not supported on web.');
        return Promise.resolve();
        // throw this.createUnimplementedError();
    }
    /**
     * Check if the splash screen is animating (always false on web).
     *
     * @returns A resolved promise with `{ isAnimating: false }`
     */
    async isAnimating() {
        return { isAnimating: false };
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    LottieSplashScreenWeb: LottieSplashScreenWeb
});

exports.LottieSplashScreen = LottieSplashScreen;
//# sourceMappingURL=plugin.cjs.js.map

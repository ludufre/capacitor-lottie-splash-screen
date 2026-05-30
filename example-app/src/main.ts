import { bootstrapApplication } from '@angular/platform-browser';
import { RouteReuseStrategy, provideRouter, withPreloading, PreloadAllModules } from '@angular/router';
import { IonicRouteStrategy, provideIonicAngular } from '@ionic/angular/standalone';

import { routes } from './app/app.routes';
import { AppComponent } from './app/app.component';
import { provideAppInitializer, provideZoneChangeDetection } from '@angular/core';
import { LottieSplashScreen } from 'capacitor-lottie-splash-screen';

bootstrapApplication(AppComponent, {
  providers: [
    provideZoneChangeDetection(),
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    provideIonicAngular(),
    provideRouter(routes, withPreloading(PreloadAllModules)),
    // provideAppInitializer(() => {
    //   // inject(...).init();
    //   return LottieSplashScreen.appLoaded();
    // }),
  ],
});

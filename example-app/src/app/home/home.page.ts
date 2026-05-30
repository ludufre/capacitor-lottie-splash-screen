import { Component } from '@angular/core';
import { IonHeader, IonToolbar, IonTitle, IonContent, IonButton } from '@ionic/angular/standalone';
import { LottieSplashScreen, LottieSplashScreenShowOptions } from '../../../../dist/esm';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  imports: [IonHeader, IonToolbar, IonTitle, IonContent, IonButton],
})
export class HomePage {
  constructor() {}

  protected showSplashScreen(): void {
    const options: LottieSplashScreenShowOptions = {
      animation: 'public/assets/lottie-runtime.json',
      isDarkMode: true,
    };
    LottieSplashScreen.show(options);
  }
}

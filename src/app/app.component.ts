import { Component, ChangeDetectionStrategy } from '@angular/core';
import { FirebaseAuthenticationService } from './core';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
  changeDetection: ChangeDetectionStrategy.Eager,
  standalone: false,
})
export class AppComponent {
  constructor(
    private readonly firebaseAuthenticationService: FirebaseAuthenticationService,
  ) {
    this.initializeApp();
  }

  private async initializeApp(): Promise<void> {
    await this.firebaseAuthenticationService.initialize();
  }
}

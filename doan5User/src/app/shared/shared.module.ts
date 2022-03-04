import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';
import { RouterModule } from '@angular/router';
import { DateVNPipe } from './pipe/pipe.module';

@NgModule({
  declarations: [HeaderComponent, FooterComponent,DateVNPipe],
  imports: [CommonModule, RouterModule],
  exports: [CommonModule, HeaderComponent, FooterComponent,DateVNPipe],
})
export class SharedModule {}

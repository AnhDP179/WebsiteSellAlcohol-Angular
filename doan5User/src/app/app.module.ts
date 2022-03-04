import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ErrorInterceptor } from './core/service/error.interceptor';
import { JwtInterceptor } from './core/service/jwt.interceptor';
import { LoginComponent } from './login/login.component';
import { SharedModule } from './shared/shared.module';
import { RegistrationComponent } from './registration/registration.component';

@NgModule({
  declarations: [AppComponent,LoginComponent, RegistrationComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    SharedModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    FormsModule,


  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}

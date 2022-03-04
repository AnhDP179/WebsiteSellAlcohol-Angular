import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HomeComponent } from './home/home.component';
import { ProductComponent } from './product/product.component';
import { ProductDetailComponent } from './product-detail/product-detail.component';
import { CartComponent } from './cart/cart.component';
import { CheckoutComponent } from './checkout/checkout.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { ContactComponent } from './contact/contact.component';
import { AboutComponent } from './about/about.component';
import { Role } from '../models/role';
import { NgbModule,NgbPagination } from '@ng-bootstrap/ng-bootstrap';
import { CoreModule } from '../core/core.module';
import { AuthGuard, RoleGuard } from '../core/service/auth.guard';

@NgModule({
  declarations: [
    HomeComponent,
    ProductComponent,
    ProductDetailComponent,
    CartComponent,
    CheckoutComponent,
    ContactComponent,
    AboutComponent,
  ],
  imports: [
    CoreModule,
    NgbModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule.forChild([
      { path: '', component: HomeComponent },
      { path: 'home', component: HomeComponent },
      { path: 'product', component: ProductComponent },
      { path: 'product_detail/:id', component: ProductDetailComponent },
      { path: 'cart', component: CartComponent},
      {
        path: 'checkout',
        component: CheckoutComponent,
        canActivate: [AuthGuard]
      },
      { path: 'contact', component: ContactComponent },
      { path: 'about', component: AboutComponent }
    ]),
  ],
})
export class PagesModule {}

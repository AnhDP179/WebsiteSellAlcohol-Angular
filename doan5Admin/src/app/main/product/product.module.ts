import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { OrderComponent } from './order/order.component';
import { ProductComponent } from './product/product.component';
import { TypeComponent } from './type/type.component';
import { SharedModule } from 'src/app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DialogModule } from 'primeng/dialog';
import { ButtonModule } from 'primeng/button';
import { DropdownModule } from 'primeng/dropdown';
import { PanelModule } from 'primeng/panel';
import { TableModule } from 'primeng/table';
import { CustomerComponent } from './customer/customer.component';

@NgModule({
  declarations: [ 
    OrderComponent,ProductComponent,TypeComponent,CustomerComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    SharedModule,
    DialogModule,
    ButtonModule,
    DropdownModule,
    PanelModule,
    TableModule,
    ReactiveFormsModule,
    RouterModule.forChild([
      {
        path: 'order',
        component: OrderComponent,
      },
      {
        path: 'product',
        component: ProductComponent,
      },
      {
        path: 'type',
        component: TypeComponent,
      },
      {
        path: 'customer',
        component: CustomerComponent,
      },
  ]),  
  ]
})
export class ProductModule { }

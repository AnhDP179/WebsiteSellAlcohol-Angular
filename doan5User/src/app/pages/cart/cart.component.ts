import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BaseComponent } from 'src/app/core/base-component';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent extends BaseComponent implements OnInit, AfterViewInit {
  items:any;
  total:any;
  constructor(injector: Injector, private router: Router) { 
    super(injector);
  }
  ngOnInit(): void {
    window.scroll(0,0);

    this._cart.items.subscribe((res) => {
      this.items = res;
      this.total = 0;
      for(let x of this.items){ 
        x.giaBan = x.quantity * x.price;
        this.total += x.quantity * x.price;
      } 
    });
  }
  clearCart() { 
    this._cart.clearCart();
    alert('Xóa thành công');
  }
  addQty(item, quantity){ 
    item.quantity =  quantity;
    item.giaBan =  Number.parseInt(item.quantity) *  item.price;
    this._cart.addQty(item);
  }
  onHome() {
    this.router.navigate(['/'])
  }
  ngAfterViewInit() { 
    this.loadScripts(); 
   }
}

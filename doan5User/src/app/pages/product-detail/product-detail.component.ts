
import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BaseComponent } from 'src/app/core/base-component';
import { Product } from 'src/app/models/product';

@Component({
  selector: 'app-product-detail',
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.css']
})
export class ProductDetailComponent extends BaseComponent implements OnInit {
  //  product:Product=new Product();
   public cate:any;
   public product:any;

  constructor(injector: Injector,private route: ActivatedRoute) { 
    super(injector);
  }
  ngOnInit(): void {
    window.scroll(0,0);
    this.route.params.subscribe(params => {
     let id = params['id'];
     this._api.get('/api/sanpham/get-by-id/' + id).takeUntil(this.unsubscribe).subscribe(res => {
       this.product = res;
       setTimeout(() => {
         this.loadScripts();
       });
     });
   });
   this._api.get('/api/loaisanpham/get-all').takeUntil(this.unsubscribe).subscribe(res => {
    this.cate = res;   
  }); 

 }
 addToCart(it) {
  this._cart.addToCart(it);
  alert('Thêm thành công!');
}
}


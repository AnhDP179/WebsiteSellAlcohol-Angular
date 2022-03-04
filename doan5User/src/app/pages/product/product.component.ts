import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs-compat';
import { BaseComponent } from 'src/app/core/base-component';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css'],
})
export class ProductComponent extends BaseComponent implements OnInit {
  public list_item: any;
  public page = 1;
  public pageSize = 3;
  public totalItems: any;
  public formsearch: any;
  public categories:any


  constructor(
    injector: Injector,
    private route: ActivatedRoute
  ) {
    super(injector);
  }

  ngOnInit(): void {
    window.scroll(0,0);
    this.route.params.subscribe(params => {
      let wine_name = params['wine_name'];
      this._api.post('/api/sanpham/search',{page: this.page, pageSize: this.pageSize, wine_name: wine_name}).takeUntil(this.unsubscribe).subscribe(res => {
        this.list_item = res.data;
        this.totalItems = res.totalItems;
        this.pageSize = res.pageSize;
        setTimeout(() => {
          this.loadScripts();
        });
      });
    });
    this._api.get('/api/loaisanpham/get-all').takeUntil(this.unsubscribe).subscribe(res => {
      this.categories = res;   
    }); 
  }

  loadPage(page) { 
    this._route.params.subscribe(params => {
      let wine_name = params['wine_name'];      
      this._api.post('/api/sanpham/search', { page: page, pageSize: this.pageSize, wine_name: wine_name}).takeUntil(this.unsubscribe).subscribe(res => {
        this.list_item = res.data;
        this.totalItems = res.totalItems;
        this.pageSize = res.pageSize;
        setTimeout(() => {
          this.loadScripts();
        });
        }, err => { });       
   });   
  }

  addToCart(it) {
    this._cart.addToCart(it);
    alert('Thêm thành công!');
  }
}

import { HttpClient } from '@angular/common/http';
import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BaseComponent } from 'src/app/lib/base-component';

@Component({
  selector: 'app-best-selling',
  templateUrl: './best-selling.component.html',
  styleUrls: ['./best-selling.component.css']
})

export class BestSellingComponent extends BaseComponent implements OnInit {
  public products: any;
  public page = 1;
  public pageSize = 10;
  public totalItems:any;
  public formsearch: any;
  public getBestSelling:any;
  public arrTenSanPham = [];
  public arrSoLuong = [];
  constructor(injector: Injector ,private route: ActivatedRoute, private router: Router,   private fb: FormBuilder,private httpclient: HttpClient
    ) {
    super(injector);
  }

  ngOnInit(): void {
    this.formsearch = this.fb.group({
      'wine_name': ['']
    });
    this.search(); 
  }
  search() { 
    this.page = 1;
    this.pageSize = 10;
    this._api.post('/api/thongke/get-sanpham-banchay',{page: this.page, pageSize: this.pageSize, wine_name: this.formsearch.get('wine_name').value}).takeUntil(this.unsubscribe).subscribe(res => {
      this.products = res;
      this.products.data.forEach(item => {
        this.arrTenSanPham.push(item.wine_name);
      });
      this.products.data.forEach(item => {
        this.arrSoLuong.push(item.slbc);
      });
      this.getBestSelling = {
        labels: this.arrTenSanPham,
        datasets: [
          {
            label: 'Số lượng bán chạy',
            backgroundColor: 'red',
            data: this.arrSoLuong
          },
        ]
      }
    });
  }

}

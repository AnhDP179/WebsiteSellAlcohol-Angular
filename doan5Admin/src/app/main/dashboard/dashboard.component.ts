import { Component, Injector, OnInit } from '@angular/core';
import { BaseComponent } from 'src/app/lib/base-component';
import 'rxjs/add/operator/takeUntil';
import 'rxjs/add/observable/combineLatest';
import { FormBuilder,NgForm } from '@angular/forms';
import { Statistical } from 'src/app/models/statistical';
import { HttpClient } from '@angular/common/http';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent extends BaseComponent implements OnInit {
  public slhd: any;
  public slnd: any;
  public slsp: any;
  public slloaisp: any;
  // public page=1;
  // public pageSize=5;
  // product_singles: Statistical = new Statistical();
  // public totalRecords:any;
  // public formsearch: any;
  // public formdata: any;
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
  formProduct: FormBuilder;

  ngOnInit(): void {

    this._api
      .get('/api/thongke/get-soluong-loaisanpham')
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.slloaisp = res;
      });
    this._api
      .get('/api/thongke/get-soluong-sanpham')
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.slsp = res;
      });
    this._api
      .get('/api/thongke/get-soluong-nguoidung')
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.slnd = res;
      });
    this._api
      .get('/api/thongke/get-soluong-hoadon')
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.slhd = res;
      });    
  }

}

import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, NgForm, Validators } from '@angular/forms';
import { FileUpload } from 'primeng/fileupload';
import { BaseComponent } from 'src/app/lib/base-component';
import 'rxjs/add/operator/takeUntil';
import 'rxjs/add/observable/combineLatest';
import { Product } from 'src/app/models/product';
import { Type } from 'src/app/models/type';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css'],
})
export class ProductComponent extends BaseComponent implements OnInit {
  public product_singles: any;
  public totalRecords: any;
  public pageSize = 10;
  public page = 1;
  public uploadedFiles: any[] = [];
  public formsearch: any;
  public formdata: any;
  public doneSetupForm: any;
  public showUpdateModal: any;
  public isCreate: any;
  public id: any;
  product_single: Product = new Product();
  submitted = false;

  public type: Type[];
  selectedCategory: Type;

  formProduct: FormBuilder;

  @ViewChild(FileUpload, { static: false }) file_image: FileUpload; //uk
  constructor(
    private httpclient: HttpClient,
    private fb: FormBuilder,
    injector: Injector
  ) {
    super(injector);
  }
  isEdit: boolean = false;
  file: any;

  ngOnInit(): void {
    this.formsearch = this.fb.group({
      wine_name: [''],
      alcohol_concentration: [''],
    });
    this.search();
  }

  loadPage(page) {
    this._api
      .post('/api/sanpham/search', {
        page: page,
        pageSize: this.pageSize,
      })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.product_singles = res.data;
        this.totalRecords = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }

  search() {
    this.page = 1;
    this.pageSize = 10;
    this._api
      .post('/api/sanpham/search', {
        page: this.page,
        pageSize: this.pageSize,
        wine_name: this.formsearch.get('wine_name').value,
        alcohol_concentration: this.formsearch.get('alcohol_concentration')
          .value,
      })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        this.product_singles = res.data;
        this.totalRecords = res.totalItems;
        this.pageSize = res.pageSize;
      });
  }

  pwdCheckValidator(control) {
    var filteredStrings = { search: control.value, select: '@#!$%&*' };
    var result = (
      filteredStrings.select.match(
        new RegExp('[' + filteredStrings.search + ']', 'g')
      ) || []
    ).join('');
    if (control.value.length < 6 || !result) {
      return { amount: true };
    }
  }

  get f() {
    return this.formdata.controls;
  }

  displayAdd: boolean = false;

  createModal() {
    this.displayAdd = true;
    this._api
      .get('/api/loaisanpham/get-all')
      .takeUntil(this.unsubscribe)
      .subscribe((res: any) => {
        this.type = res;
      });
  }

  // file: any;
  // image?: string;
  picture: any = null;

  onChange(event: any) {
    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.file = file;
    }
    // this.picture = event.target.files[0];

    // var reader = new FileReader();
    // reader.readAsDataURL(event.target.files[0]);
    // reader.onload = (e: any) => {
    //   this.image = e.target.result;
    // };
  }
  upload(file?: any): Observable<any> {
    const apiURL = 'http://localhost:49354/api/sanpham/upload';
    const formData = new FormData();
    formData.append('file', file, file.name);
    return this.httpclient.post(apiURL, formData).pipe();
  }


  AddNewProduct(form: NgForm) {
    console.log(form.value);
    try {
      if (this.file) {
        const formData = new FormData();
        formData.append('file', this.file);
        this._api.uploadFile(formData)
          .subscribe(res => {
            const sanpham: Product = new Product();
            sanpham.product_id = form.controls['product_id'].value;
            sanpham.wine_name = form.controls['wine_name'].value;
            sanpham.capacity = form.controls['capacity'].value;
            sanpham.amount = form.controls['amount'].value;
            sanpham.price = form.controls['price'].value;
            sanpham.alcohol_concentration =
              form.controls['alcohol_concentration'].value;
            sanpham.picture = res.filePath;
            this.loadPage(this.page);
            this._api
              .post('/api/sanpham/create', sanpham)
              .takeUntil(this.unsubscribe)
              .subscribe(
                (res) => {
                  alert('Thêm mới thành công');
                  this.resetform(form);
                  this.search();
                  this.displayAdd = false;
                },
                (err) => {
                  console.log(err);
                }
              );
          })
      }
    } catch (error) {
      console.log(error);
    }
  }

  onDelete(row) {
    this._api
      .post('/api/sanpham/delete', { id: row.id })
      .takeUntil(this.unsubscribe)
      .subscribe((res) => {
        alert('Xóa thành công');
        this.search();
      });
  }

  resetform(form) {
    if (form != null) form.resetForm();
  }
  openUpdateModal(product: Product) {
    this.product_single = product;
    this._api
      .get('/api/loaisanpham/get-all')
      .takeUntil(this.unsubscribe)
      .subscribe((res: any) => {
        this.type = res;
      });

    this.isEdit = true;
  }

  SaveData() {
    try {
      this._api
        .post('/api/sanpham/update', this.product_single)
        .takeUntil(this.unsubscribe)
        .subscribe(
          (res) => {
            alert('Cập nhật thành công');
            this.search();
            this.isEdit = false;
          },
          (err) => {
            console.log(err);
          }
        );
    } catch (error) {
      console.log(error);
    }
  }

}

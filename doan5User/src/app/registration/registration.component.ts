import { HttpClient } from '@angular/common/http';
import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, NgForm } from '@angular/forms';
import { BaseComponent } from '../core/base-component';
import { Customer } from '../models/customer';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent extends BaseComponent implements OnInit {


  constructor(    private httpclient: HttpClient,
    private fb: FormBuilder,
    injector: Injector) {
    super(injector);
  }
  ngOnInit(): void {
  }
  ngAfterViewInit() { 
    this.loadScripts(); 
   }
   resetform(form) {
    if (form != null) form.resetForm();
  }
  AddNewProduct(form: NgForm) {
    console.log(form.value);
    try {
            const khach: Customer = new Customer();
            khach.customerName = form.controls['customerName'].value;
            khach.dateOfBirth = form.controls['dateOfBirth'].value;
            khach.address = form.controls['address'].value;
            khach.phone = form.controls['phone'].value;
            khach.email = form.controls['email'].value;
            khach.password =
              form.controls['password'].value;
            this._api
              .post('/api/customer/create', khach)
              .takeUntil(this.unsubscribe)
              .subscribe(
                (res) => {
                  alert('Đăng kí thành công');
                  this.resetform(form);
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

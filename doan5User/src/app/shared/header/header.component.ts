import { Component, Injector, OnInit } from '@angular/core';
import { BaseComponent } from 'src/app/core/base-component';
import { AuthenticationService } from 'src/app/core/service/authentication.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent extends BaseComponent implements OnInit {
  items:any;
  total:any;
  constructor(injector: Injector,private authenticationService: AuthenticationService) { 
    super(injector);
  }
  ngOnInit(): void {
    this._cart.items.subscribe((res) => {
      this.items = res;
      this.total = 0;
      for(let x of this.items){ 
        x.money = x.quantity * x.price;
        this.total += x.quantity * x.price;
      } 
    });
  }
  logout() {
    this.authenticationService.logout();
  } 
}

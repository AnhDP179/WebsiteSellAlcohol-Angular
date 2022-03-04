import { AfterViewInit, Component, Injector, OnInit } from '@angular/core';
import { Observable } from 'rxjs-compat';
import { BaseComponent } from 'src/app/core/base-component';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent
  extends BaseComponent
  implements OnInit, AfterViewInit
{
  public list_item: any;
  constructor(injector: Injector) {
    super(injector);
  }

  ngOnInit(): void {
    Observable.combineLatest([this._api.get('/api/sanpham/get-all')])
      .takeUntil(this.unsubscribe)
      .subscribe(
        (res) => {
          const size = 5
          this.list_item = res[0];
          setTimeout(() => {
            this.loadScripts();
          });
        },
        (err) => {
          throw err;
        }
      );
  }
  ngAfterViewInit() {
    this.loadScripts();
  }
}

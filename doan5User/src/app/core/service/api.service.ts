import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { catchError, map } from 'rxjs/operators';
import { throwError as observableThrowError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ApiService {
  public host = 'http://localhost:49354';
  constructor(private _http: HttpClient, public router: Router) {}
  post(url: string, obj: any) {
    const body = JSON.stringify(obj);
    let cloneHeader: any = {};
    cloneHeader['Content-Type'] = 'application/json';
    const headerOptions = new HttpHeaders(cloneHeader);
    return this._http
      .post<any>(this.host + url, body, { headers: headerOptions })
      .pipe(
        map((res: any) => {
          return res ;
        })
      ).pipe(
        catchError((err: Response) => {
          return this.handleError(err);
        })
      );
  }

  get(url: string) {
    let cloneHeader: any = {};
    cloneHeader['Content-Type'] = 'application/json';
    const headerOptions = new HttpHeaders(cloneHeader);
    return this._http
      .get(this.host + url, { headers: headerOptions })
      .pipe(
        map((res: any) => {
          return res;
        })
      ).pipe(
        catchError((err: Response) => {
          return this.handleError(err);
        })
      );
  }
  public handleError(error: any) {
    this.router.navigate(['/err']);
    return observableThrowError(error);
  }
}


// import { HttpClient, HttpHeaders } from '@angular/common/http';
// import { Injectable } from '@angular/core';
// import { Router } from '@angular/router';
// import { map } from 'rxjs/operators';
// import { environment } from 'src/environments/environment';

// @Injectable({
//   providedIn: 'root',
// })
// export class ApiService {
//   public host = environment.apiUrl;
//   constructor(private _http: HttpClient, public router: Router) {}

//   post(url: string, obj: any) {
//     const body = JSON.stringify(obj);
//     return this._http
//       .post<any>(this.host + url, body)
//       .pipe(
//         map(res => {
//           return res;
//         })
//       );      
//   }

//   get(url: string) {
//     return this._http
//       .get(this.host + url)
//       .pipe(
//         map(res  => {
//           return res;
//         })
//       );       
//   } 
// }

import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import 'rxjs/add/operator/map';


// Import the user model
import {User} from '../../models/user'

/*
  Generated class for the GithubUsers provider.

  See https://angular.io/docs/ts/latest/guide/dependency-injection.html
  for more info on providers and Angular 2 DI.
*/
@Injectable()
export class GithubUsers {
  //add users
  githubUsers: any = null;
  
  constructor(public http: Http) {}

  load() {
    if (this.githubUsers) {
      // already loaded users
      return Promise.resolve(this.githubUsers);
    }

    // don't have the users yet
    return new Promise(resolve => {
      // We're using Angular Http provider to request the users,
      // then on the response it'll map the JSON data to a parsed JS object.
      // Next we process the users and resolve the promise with the new data.
      this.http.get('https://api.github.com/users')
        .map(res => <Array<User>>(res.json()))
        .subscribe(users => {
          // we've got back the raw users, now generate the core schedule users
          // and save the users for later reference

            // for (var i =0; i< users.length; i++)
            // {
            //      console.log(users[i].tostring())
            // }

          this.githubUsers = users;
          resolve(this.githubUsers);
        });
    });
  }


  // Get user details from the github api  
  loadDetails(login: string) {
    // get the data from the api and return it as a promise
    console.log("providers github users get:"+login)
    return new Promise<User>(resolve => {
      // Change the url to match https://api.github.com/users/{username}
      this.http.get('https://api.github.com/users/'+login)
        .map(res => <User>(res.json()))
        .subscribe(user => {
          console.log("check final user:"+user);
          resolve(user);
        });
    });
  }



   // Search for github users  
  searchUsers(searchParam: string) {
    // get the data from the api and return it as a promise
    return new Promise<Array<User>>(resolve => {
      // Change the url to match https://api.github.com/search/users?q={searchParam}
      this.http.get(`https://api.github.com/search/users?q=${searchParam}`)
        // Cast the result into an array of users. 
        // The returned json result has an items
        // property which contains the users
        .map(res => <Array<User>>(res.json().items))
        .subscribe(users => {
          resolve(users);
        });
    });
  }

}



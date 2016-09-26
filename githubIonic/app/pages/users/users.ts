import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

// Import GithubUsers provider
import {GithubUsers} from '../../providers/github-users/github-users';

// Import User model
import {User} from '../../models/user';

// Import User's Details Page
import {UserDetailsPage} from '../user-details/user-details';


/*
  Generated class for the UsersPage page.

  See http://ionicframework.com/docs/v2/components/#navigation for more info on
  Ionic pages and navigation.
*/
@Component({
  templateUrl: 'build/pages/users/users.html',

  // Add the GithubUsers provider as part of our page component
  providers: [GithubUsers]
})
export class UsersPage {

  // Declare users as an array of User model
  users: User[];

   // Inject the GithubUsers in the constructor of our page component
  constructor(public nav: NavController, githubUsers: GithubUsers) {
    // Test whether the github provider returns data
    githubUsers
      .load().then(users => this.users = users)
      /*
      .then(function (users) {
        // Log the returned github users
        for (var i =0; i< users.length; i++)
        {
             console.log(users[i])
        }
    	this.users = users;
      });
      */
  }

  // Navigate to user details page with the login as a parameter  
  goToDetails(event, login) {
    this.nav.push(UserDetailsPage, {
      login: login
    });
  }

}


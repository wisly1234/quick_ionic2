# quick_ionic2

A basic framework for ionic2 and angular2

1. npm install -g cordova
2. npm install -g ionic
3. npm install -g typescript
4. npm install -g typings

5. 
ionic start project_name --v2
ionic start project_name tutorial --v2
ionic start project_name tutorial --v2 --ts



6. 
app - This is where we'll spend the most of our time building our app. It contains the structured source code of our app.
node_modules - Contains the npm packages listed in the package.json file. These are packages necessary for building the ionic app.
platforms - This is where platform specific builds, build tools and packages/libraries are stored. You will find a folder for the platform your are building on. To add a platform, android for example, simply run ionic platform add android, and this will add the folder android folder to this folder.
plugins - This is where cordova plugins will be stored when they are installed. Cordova plugins enables your app to have native functionality in the mobile device, e.g accessing the media storage of the device, or even the bluetooth API.
resources - This also contains platform specific resources.
typings - This contains files that help TypeScript infer types it is not aware of. Not all JavaScript libraries were written in TypeScript, and for TypeScript to know about them, we'll need these libraries' typings.
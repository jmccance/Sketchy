# Sketchy

## Overview

Sketchy is a (fairly primitive) web-based drawing application. You can make a new sketch, give it a name, draw to your heart's content, and it for later modification. Engage in a level of artistry not seen since the early days of MS Paint!

## Use

To launch Sketchy, you'll need Ruby 1.9, Rails 3, and MongoDB. The configuration expects MongoDB to be running on the usual port (27017) without any security restrictions.

To install the dependencies, navigate to the project root and run

   bundle install

To run the application, run

   rails server

and navigate to http://localhost:3000/sketches.

## Technical Details

Sketchy uses a handful of technologies to do its thing, including

* [Ruby on Rails](http://rubyonrails.org/)
* [MongoDB](http://mongodb.org/)
* [Knockout.js](http://knockoutjs.com/)
* [Bootstrap](http://getbootstrap.com/)

## Todo

* Expand this README file.
* Add more drawing tools.
* Implement user sign-up.
* Host a demo instance on Heroku. (After users are implemented. Because we all know what will happen to a public drawing app on the Internet.)
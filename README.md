# Ruby on Rails Tutorial sample application

This is the sample application for the
[_Ruby on Rails Tutorial:
Learn Web Development with Rails_](https://www.railstutorial.org/)
by [Michael Hartl](https://www.michaelhartl.com/).

## License

All source code in the [Ruby on Rails Tutorial](https://www.railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Before you Get started

I will suggest to follow the GoRails tutorial on installation of the following requirements to be able to clone this repository project. https://gorails.com/setup/

Here are the following version of Ruby on Rails I'm using when doing this project.

```
$ gem -v 3.4.1
$ bundler -v 2.4.1
$ ruby -v 3.2.0
$ rails -v 7.0.4.2
```

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ gem install bundler -v 2.4.1
$ bundle _2.4.1_ config set --local without 'production'
$ bundle _2.4.1_ install
```

Create the database :

```
$ rails db:create
```

Next, migrate the database:

```
$ rails db:migrate

$ rails db:seed # optional
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[_Ruby on Rails Tutorial_ book](https://www.railstutorial.org/book).

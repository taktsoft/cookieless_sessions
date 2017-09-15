# CookielessSessions
[![Gem Version](https://badge.fury.io/rb/cookieless_sessions.png)](http://badge.fury.io/rb/cookieless_sessions)
[![Build Status](https://api.travis-ci.org/taktsoft/cookieless_sessions.png)](https://travis-ci.org/taktsoft/cookieless_sessions)
[![Code Climate](https://codeclimate.com/github/taktsoft/cookieless_sessions.png)](https://codeclimate.com/github/taktsoft/cookieless_sessions)
[![Dependency Status](https://gemnasium.com/taktsoft/cookieless_sessions.svg)](https://gemnasium.com/taktsoft/cookieless_sessions)

CookielessSessions implements a fallback mechanism for keeping Session-IDs _(via GET-Parameter)_ on clients that doesn't support or allow cookies.

By default, the server sends a _Set-Cookie_ header to the client. If the client supports and allows cookies, it will send back this _Cookie_ header back in the next request. If not, then there won't be a _Cookie_ header in the next requests from the client to the server and the server will initiate a new session for the client, in every request. In this case, sessions won't work.

This is what this gem was built for. There is only one other way to transfer a Session-ID between server and client: via GET-Paramters _(and of course POST-Parameters)_.

## Implementation

There isn't any magic in this gem. This gem consists of one module which implements a concern for controllers. The important method in this module is _default_url_options_ and it only adds the _session_key_ with the _session_id_ to the options hash.

Rails uses the result of _default_url_options_ method for Path / URL generation. Because of that, the _session_key_ and _session_id_ will be added to every Paths and URL generated in _(cookieless_session enabled)_ controllers.

## Requirements

An application based on Rails 3.x or 4.x configured with a session storage that supports the _cookie_only: false_ option (e.g. [redis-session-store](https://rubygems.org/gems/redis-session-store)).

## Installation

Add this line to your application's Gemfile:

    gem 'cookieless_sessions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cookieless_sessions

## Usage

First, you need a cookie storage which supports the _cookie_only_ option and turn it off. Rails built in session storages (_cookie_store_ and _active_record_store_) doesn't support this option. That's why you need another cookie_storage. For example: this gem uses _redis_session_store_ from the [redis-session-store](https://rubygems.org/gems/redis-session-store) gem and a [Redis](http://redis.io/) database for its tests.

Include the module into the controller where you want to enable sessions via GET parameter:

```ruby
    class YourController < ApplicationController
        include CookielessSessions::EnabledController

        # ...
    end
```

If you want to enable sessions via GET parameter for the whole application, include the module into your _ApplicationController_:

```ruby
    class ApplicationController < ActionController::Base
        include CookielessSessions::EnabledController

        # ...
    end
```

If you want to disable sessions via GET parameter for a certain controller, you can do this by excepting the _sessions_key_ from the _default_url_options_:

```ruby
    class OtherController < ApplicationController
        def default_url_options
            super.except(session_key)
        end
    end
```

### Hint

If you want to overwrite _default_url_options_ in one of your controllers that use _cookieless_sessions_ and you want to keep that functionality, you should use _super.dup_ and work on a copy:

```ruby
    class AnotherController < ApplicationController
        def default_url_options
            options ||= super.dup || {}
            options[:foo] = :bar
            return options
        end
    end
```

## Security

There is one security impact: If you copy & paste a URL with your Sessions-ID to a friend and he has cookies disabled _(this won't be happen if he has cookies enabled)_, he will get your session _(e.g. he will be logged in with your account, depends on the application)_.

Two countermeasure could be to bind sessions to the client's IP-Address and add a session lifetime. For both you can use the [frikandel](https://rubygems.org/gems/frikandel) gem. This should make it harder to steal and fix sessions.

## Test

To run the test suite with different rails version by selecting the corresponding gemfile. You can use this one liners:

    $ export BUNDLE_GEMFILE=Gemfile.rails-4.0.x && bundle update && bundle exec rake spec
    $ export BUNDLE_GEMFILE=Gemfile.rails-4.1.x && bundle update && bundle exec rake spec
    $ export BUNDLE_GEMFILE=Gemfile.rails-4.2.x && bundle update && bundle exec rake spec
    $ export BUNDLE_GEMFILE=Gemfile.rails-5.0.x && bundle update && bundle exec rake spec
    $ export BUNDLE_GEMFILE=Gemfile.rails-5.1.x && bundle update && bundle exec rake spec

## Changes

* v1.0.1 -- added Rails32DestroyableSessionPatch: sets SID in options on destroy
* v1.0.0 -- first release with complete README; no code changes
* v0.0.2 -- improved and more flexible version with tests
* v0.0.1 -- initial and work-in-progress version without any tests

## Contributing

1. Fork it ( https://github.com/taktsoft/cookieless_sessions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

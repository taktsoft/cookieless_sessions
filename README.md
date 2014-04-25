# CookielessSessions
[![Gem Version](https://badge.fury.io/rb/cookieless_sessions.png)](http://badge.fury.io/rb/cookieless_sessions) 
[![Build Status](https://api.travis-ci.org/taktsoft/cookieless_sessions.png)](https://travis-ci.org/taktsoft/cookieless_sessions)
[![Code Climate](https://codeclimate.com/github/taktsoft/cookieless_sessions.png)](https://codeclimate.com/github/taktsoft/cookieless_sessions)

Implements a fallback mechanism for keeping Session-IDs (via GET-Parameter) on clients that doesn't support or allow cookies.

## How it works

There isn't any magic in this gem. This gem has only one module which implements a concern for controllers. The important method in this module is _default_url_options_ and it only adds the _session_key_ with the _session_id_ to the options hash.

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

## Contributing

1. Fork it ( https://github.com/taktsoft/cookieless_sessions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# casino-moped_yubi_authenticator

Provides mechanism to use Moped/Mongoid as an authenticator for Yubi keys in [CASino](https://github.com/rbCAS/CASino).

To use the Moped Yubi authenticator, configure it in your cas.yml:

    authenticators:
      my_company_mongo:
        authenticator: "MopedYubi"
        options:
          database_url: "mongodb://localhost:27017/my_db"
          collection: "users"
          username_column: "username"
          password_column: "password"
          yubi_key_column: "registered_yubi_key"
          pepper: "suffix of the password" # optional
          extra_attributes:
            email: "email_database_column"
            fullname: "displayname_database_column"

## Contributing to casino-moped_authenticator

* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it
  and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in
  a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to
  have your own version, or is otherwise necessary, that is fine, but please
  isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Digital Natives. See LICENSE.txt for further details.


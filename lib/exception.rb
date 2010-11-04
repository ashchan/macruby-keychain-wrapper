# MacRuby Keychain Wrapper is a wrapper for accessing keychain

# Author::    James Chen  (mailto:ashchan@gmail.com, twitter:@ashchan)
# Copyright:: Copyright (c) 2010 James Chen
# License::   Distributes under the same terms as Ruby

module MRKeychain
  class ServiceNilError < StandardError; end
  class UsernameNilError < StandardError; end
  class PasswordNilError < StandardError; end
end
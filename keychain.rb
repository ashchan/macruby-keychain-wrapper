# MacRuby Keychain Wrapper is a wrapper for accessing keychain

# Author::    James Chen  (mailto:ashchan@gmail.com, twitter:@ashchan)
# Copyright:: Copyright (c) 2010 James Chen
# License::   Distributes under the same terms as Ruby

framework 'Cocoa'
framework 'Security'

%w(exception generic_item internet_item).each do |c|
  require File.join(File.expand_path(File.dirname(__FILE__)), 'lib', c)
end

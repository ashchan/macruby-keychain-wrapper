# MacRuby Keychain Wrapper #

MacRuby Keychain Wrapper is a wrapper for accessing keychain from MacRuby.

todo: more intro

# Example #

require 'keychain'

\# create a new generic item
item = MRKeychain::GenericItem.add\_item\_for_service('GmailNotifr', username:'ashchan', password:'password')

\# grab a generic item 
existing\_item = MRKeychain::GenericItem.item\_for\_service('GmailNotifr', username:'ashchan')

\# update an item
existing\_item.password = 'new_password'

\# remove from keychain
existing\_item.remove


Copyright (c) 2010 [James Chen](http://ashchan.com/) ([@ashchan](http://twitter.com/ashchan)), released under the same terms as Ruby
# MacRuby Keychain Wrapper #

MacRuby Keychain Wrapper is a wrapper for accessing keychain from MacRuby.

todo: more intro

## Examples ##

    require 'keychain'

Create a new generic item

    item = MRKeychain::GenericItem.add_item_for_service('GmailNotifr', username:'ashchan', password:'password')

Grab a generic item 

    existing_item = MRKeychain::GenericItem.item_for_service('GmailNotifr', username:'ashchan')

Update an item

    existing_item.password = 'new_password'

Remove from keychain

    existing_item.remove


Copyright (c) 2010 [James Chen](http://ashchan.com/) ([@ashchan](http://twitter.com/ashchan)), released under the same terms as Ruby
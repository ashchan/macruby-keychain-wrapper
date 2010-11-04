# MacRuby Keychain Wrapper is a wrapper for accessing keychain

# Author::    James Chen  (mailto:ashchan@gmail.com, twitter:@ashchan)
# Copyright:: Copyright (c) 2010 James Chen
# License::   Distributes under the same terms as Ruby

module MRKeychain
  class GenericItem
    attr_reader :service
    attr_accessor :username, :password

    def initialize(service, username, password, item_ref)
      @service = service
      @username = username
      @password = password
      @item_ref = item_ref
    end
    
    def username=(n)
      raise UsernameNilError if n.nil? || n.length == 0
      #TODO
    end
    
    def password=(p)
      raise PasswordNilError if p.nil? || p.length == 0
      #TODO
    end
    
    def remove
      if SecKeychainItemDelete(@item_ref) == 0
        @item_ref = nil
        true
      else
        false
      end
    end
    
    class << self
      def add_item_for_service(service, username:username, password:password)
        raise ServiceNilError if service.nil? || service.length == 0
        raise UsernameNilError if username.nil? || username.length == 0
        raise PasswordNilError if password.nil? || password.length == 0
        
        item_ref = Pointer.new('^{OpaqueSecKeychainItemRef}')
        error = SecKeychainAddGenericPassword(
          nil,
          service.length,
          service,
          username.length,
          username,
          password.length,
          password.pointer,
          item_ref)

        if error == 0 && item_ref
          new(service, username, password, item_ref[0])
        else
          nil
        end
      end
      
      def item_for_service(service, username:username)
        raise ServiceNilError if service.nil? || service.length == 0
        raise UsernameNilError if username.nil? || username.length == 0
        
        password_length = Pointer.new('I')
        password_data = Pointer.new('^v')
        item_ref = Pointer.new('^{OpaqueSecKeychainItemRef}')
        status = SecKeychainFindGenericPassword(
          nil,
          service.length,
          service,
          username.length,
          username,
          password_length,
          password_data,
          item_ref)
          
        if status == 0 && item_ref
          password = ""
          password_length[0].times do |i|
            password << password_data[0][i]
          end
          new(service, username, password, item_ref[0])
        else
          nil
        end
      end
    end
  end 
end
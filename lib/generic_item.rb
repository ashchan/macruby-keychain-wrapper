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
      raise "NotImplYet"
      #kSecAccountItemAttr = 1633903476
      modify_attribute_with_tag(1633903476, value:n)
      @username = n
    end
    
    def password=(p)
      raise PasswordNilError if p.nil? || p.length == 0
      pwd = "#{p.to_s}"
      SecKeychainItemModifyAttributesAndData(@item_ref, nil, pwd.length, pwd.pointer)
      @password = p
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

        pwd = "#{password.to_s}"
        item_ref = Pointer.new('^{OpaqueSecKeychainItemRef}')
        error = SecKeychainAddGenericPassword(
          nil,
          service.length,
          service,
          username.length,
          username,
          pwd.length,
          pwd.pointer,
          item_ref)

        if error == 0 && item_ref
          new(service, username, password, item_ref[0])
        else
          nil
        end
      end
      
      def item_for_service(service, username = '')
        raise ServiceNilError if service.nil? || service.length == 0
        
        password_length = Pointer.new('I')
        password_ptr = Pointer.new('^v')
        item_ref = Pointer.new('^{OpaqueSecKeychainItemRef}')
        error = SecKeychainFindGenericPassword(
          nil,
          service.length,
          service,
          username.length,
          username,
          password_length,
          password_ptr,
          item_ref)
          
        if error == 0 && item_ref
          password = NSString.alloc.initWithBytes(password_ptr[0], length:password_length[0], encoding:NSASCIIStringEncoding)
          new(service, username, password, item_ref[0])
        else
          nil
        end
      end
    end
    
    private
    def modify_attribute_with_tag(attr_tag, value:v)
      return unless @item_ref

      # TODO: make this work
    	attrs = SecKeychainAttributeList.new(1, SecKeychainAttribute.new(attr_tag, v.length, v.pointer))

    	SecKeychainItemModifyAttributesAndData(@item_ref, attrs, 0, nil)
  	end
  end
end
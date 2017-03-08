module Ohby
  # Object representation of an 0x-code.
  #
  # @author Jan Lindblom <janlindblom@fastmail.fm>
  # @version 0.0.1
  # @since 0.0.1
  class Code < Object
    # The code itself
    attr_accessor :code
    # The message, or contents, this code represents
    attr_accessor :message
    # The date this 0x-code was created
    attr_accessor :date
    # The expiry of this code
    attr_accessor :expires
    # The visibility of this code
    attr_accessor :visibility
    # The Sha256 hash of this code
    attr_accessor :hash
    # Redirect flag on this code
    attr_accessor :redirect

  end
end

module Spec # :nodoc:
  module VERSION # :nodoc:
    unless defined? MAJOR
      MAJOR  = 1
      MINOR  = 2
      TINY   = 1
      
      STRING = [MAJOR, MINOR, TINY].compact.join('.')

      SUMMARY = "rspec #{STRING}"
    end
  end
end
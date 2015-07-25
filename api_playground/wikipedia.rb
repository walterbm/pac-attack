require 'wikipedia'
require 'pry'
page = Wikipedia.find( 'obama barack' )
binding.pry
puts page.images
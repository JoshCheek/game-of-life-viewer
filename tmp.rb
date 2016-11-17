require 'chunky_png'

white = ChunkyPNG::Color::WHITE
black = ChunkyPNG::Color::BLACK
image = ChunkyPNG::Image.new 100, 100, black

10.times do |y|
  10.times do |x|
    next if x.even? != y.even?
    image.rect x*10, y*10, x*10+10, y*10+10, black, white
  end
end

image.save 'tmp.png'
puts <<`BASH`
imgcat tmp.png
imgcat tmp.png | escape
BASH

b64_filename = ['tmp.png'].pack('m0')
size = image.to_blob.bytesize
b64  = [image.to_blob].pack('m0')
puts "\e]1337;File=#{b64_filename};size=#{size};inline=1:#{b64}\a"

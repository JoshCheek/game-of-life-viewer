Game of Life -- visual
======================

Mostly just an excuse to play with image generation.


How to play with it
-------------------

Assuming you have Ruby, install ChunkyPNG

```Sh
$ gem install chunky_png
```

Then run the binary

```sh
$ bin/gol
```

As of right now, you have to edit the binary to change its settings.
This probably won't change, b/c who gives a shit?

You can make a video by editing `should_save` to true and then running its screenshots through ffmpeg
(on a mac, get `ffmpeg` from homebrew)

```sh
$ ffmpeg -r 60 -i screenshots/2016-11-17-05:03:21/%06d.png -pix_fmt yuv420p example.mp4
```


Example of creating and printing a PNG in iTerm2
------------------------------------------------

```ruby
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
```

License
-------

[WTFPL](http://www.wtfpl.net/about/) Just do what the fuck you want to.

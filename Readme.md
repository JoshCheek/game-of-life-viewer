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


License
-------

[WTFPL](http://www.wtfpl.net/about/) Just do what the fuck you want to.

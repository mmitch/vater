vater – Vala terminal emulator
==============================

`vater` is a small terminal emulator written in [Vala].  It is mostly
using on the [VTE] library which provides the terminal emulator and
just configures it in the way I want.

This is based on an idea from [Write your own terminal emulator] - in
fact I converted the C code from there to Vala as a starting point.


installation
------------

* just run `make`

  it will compile `vater` and try to install it into `~/bin`, so you
  should a) have that directory and b) have it in your `$PATH`

* for bitmap fonts to work, you propably have to tweak your Fontconfig
  settings

  Bitmap fonts are mostly deactivated by default (eg. Ubuntu has
  `/etc/fonts/conf.d/70-no-bitmaps.conf`).  Activating *all* the
  bitmap fonts could lead to problems, so just activate the `fixed`
  font family by creating a configuration file
  `/etc/fonts/conf.d/99-enable-fixed-bitmap.conf` and run `fc-cache`
  afterwards or restart your X session (based on [this idea]).

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <!-- Enable (efont) fixed bitmap fonts -->
  <selectfont>
    <acceptfont>
      <pattern>
        <patelt name="family">
          <string>fixed</string>
        </patelt>
      </pattern>
    </acceptfont>
  </selectfont>
</fontconfig>
```

* to enable the `efont` bitmap font family, you have to jump through
  additional hoops

  I have selected `efont` as a Pango font name in the `vater` source.
  FontConfig maps all bitmap fonts to `Fixed`, so you need additional
  configuration settings in your `~/.config/fontconfig/fonts.conf` for
  this to work.  See the generated `fonts.conf` file for a possible
  solution.  Beware of all the hardcoded paths in there (should work
  with at least Ubuntu and the `xfonts-efont-unicode` package).
  Because I don't see how to distinguish between normal and wide
  characters in FontConfig, only normal characters are mapped to
  `efont`: the `h*.pcf.gz` files are used, while `f*.pcf.gz` are
  skipped.  This leaves all Japanese characters in a non-bitmapped
  font which actually does not look too shabby for my tastes ;-)


bugs/todos
----------

* clipboard paste problem

  Over SSH, I was only able to paste the first line of several lines
  in the clipboard (*this needs some further investigation*).  Could
  be related to my colored prompt and all the escape sequences in
  there.  I think there is code (= further escape sequences) in my
  prompt that makes xterm only select the plain text but not the color
  codes.  Perhaps this is missing from VTE.  Hopefully there are hooks
  available.

* use Github issues

  This is a Github project, so why keep a list of issues in the
  README?  Just add them as Github issues ;-)

* add TravisCI build

  No unit tests, but a plain “is the build broken?” check.  [TravisCI]
  does not support Vala, but it should be possible to just
  `apt-install valac` (with cacheing, we want to be nice) and then run
  the `Makefile`.

* terminal colors

  default/white is not white enough, it's more of a light bluish grey


[Vala]: https://wiki.gnome.org/Projects/Vala
[VTE]: https://wiki.gnome.org/Apps/Terminal/VTE
[Write your own terminal emulator]: https://vincent.bernat.im/en/blog/2017-write-own-terminal
[efont]: http://openlab.ring.gr.jp/efont/unicode/
[TravisCI]: https://travis-ci.org/
[this idea]: http://marklodato.github.io/2014/02/23/fixed-fonts.html

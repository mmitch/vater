vater – Vala terminal emulator
==============================

[![Linux Build status](https://github.com/mmitch/vater/workflows/Linux%20Build/badge.svg?branch=master)](https://github.com/mmitch/vater/actions?query=workflow%3A%22Linux+Build%22)

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


configuration
-------------

At startup, `vater` looks for these environment variables:

* `VATER_FONT` controls the font to use.  It is passed to Fontconfig,
  so a valid value should look something like `Noto Mono 11` (which
  currently is the default font).

* `VATER_SELECT_TO_CLIPBOARD` controls selection mode.  By default,
  selected text is only copied to the X11 primary selection.  If
  `VATER_SELECT_TO_CLIPBOARD` is set to `1`, selected text is
  additionally copied to the X11 clipboard.


bitmap font selection
---------------------

`vater` was originally designed to use the `efont` bitmap fonts.  This
gets harder and harder as classical bitmap fonts managed by the X
server are not en vogue any more.  My last success using `efont`
worked like this:

* install the `efont` font

  On Debian and Ubuntu, it's in the `xfonts-efont-unicode` and
  `xfonts-efont-unicode-ib` packages.  Otherwise see [efont].

* for bitmap fonts to work, you might have to tweak your Fontconfig
  settings

  Bitmap fonts are mostly deactivated by default (eg. Ubuntu has
  `/etc/fonts/conf.d/70-no-bitmaps.conf`).  Activating *all* the
  bitmap fonts could lead to problems, so just activate the `efont`
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
          <string>BiWidth</string>
        </patelt>
      </pattern>
    </acceptfont>
  </selectfont>
</fontconfig>
```

* set `VATER_FONT` to `BiWidth`

* no, I don't know why Fontconfig insists on calling `efont` `BiWidth`
  
  But I'm happy that it worked!  Took long enough...


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


[Vala]: https://wiki.gnome.org/Projects/Vala
[VTE]: https://wiki.gnome.org/Apps/Terminal/VTE
[Write your own terminal emulator]: https://vincent.bernat.im/en/blog/2017-write-own-terminal
[efont]: http://openlab.ring.gr.jp/efont/unicode/
[TravisCI]: https://travis-ci.org/
[this idea]: http://marklodato.github.io/2014/02/23/fixed-fonts.html

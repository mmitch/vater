vater – Vala terminal emulator
==============================

`vater` is a small terminal emulator written in [Vala].  It is mostly
using on the [VTE] library which provides the terminal emulator and
just configures it in the way I want.

This is based on an idea from [Write your own terminal emulator] - in
fact I converted the C code from there to Vala as a starting point.


bugs/todos
----------

* no bitmap fonts available

  I don't like anti-aliased fonts for terminal work, so I want my
  bitmapped [efont] back.  VTE uses GTK3, GTK3 uses Pango, Pango uses
  Fontconfig and Fontconfig seems to be the culprit here.  I will try
  this: http://marklodato.github.io/2014/02/23/fixed-fonts.html
  
* clipboard selection problem

  Unlike xterm, VTE does not select a whole URL on double click, but
  stops at the colon, so I either select the protocol path (`http`) or
  everything else (`//example.org`).  This is not acceptable.  I must
  find a way to remove `:` from being a word delimiter.

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



[Vala]: https://wiki.gnome.org/Projects/Vala
[VTE]: https://wiki.gnome.org/Apps/Terminal/VTE
[Write your own terminal emulator]: https://vincent.bernat.im/en/blog/2017-write-own-terminal
[efont]: http://openlab.ring.gr.jp/efont/unicode/
[TravisCI]: https://travis-ci.org/

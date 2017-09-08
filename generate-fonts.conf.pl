#!/usr/bin/env perl
use strict;
use warnings;

my @PATHS = qw( /usr/share/fonts/X11/misc/ );

print << 'EOF';
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
EOF
;

foreach my $path (@PATHS) {
    chdir $path;
    foreach my $file (glob "*.pcf.gz") {
	next unless $file =~ /^h(\d+)(?:_([bi]+))?\.pcf.gz$/;
	my ($size, $type) = ($1, $2);

	# different variants don't work?
	# only use 14pt regular for now
	next if $size != 14;
	next if defined $type;
	
	my $weight = 80;
	my $slant = 0;

	if (defined $type) {
	    $weight = 200 if $type =~ /b/;
	    $slant = 100 if $type =~ /i/;
	}

	print << "EOF";
  <match target="pattern">
    <test name="family" compare="eq">
      <string>efont</string>
    </test>
<!--    <test name="pointsize" compare="eq">
      <double>$size</double>
    </test>
    <test name="weight" compare="eq">
      <int>$weight</int>
    </test>
    <test name="slant" compare="eq">
      <int>$slant</int>
    </test> -->
    <edit name="file" mode="assign">
      <string>$path$file</string>
    </edit>
  </match>
EOF
	;
    }
}

print << 'EOF';
</fontconfig>
EOF
;


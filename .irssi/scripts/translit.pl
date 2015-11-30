use strict;
use vars qw(%IRSSI);

use Irssi;
%IRSSI = (
  authors     => 'dreg',
  contact     => 'dreg@fine.lv',
  name        => 'translit',
  description => 'translitiratar',
  license     => 'GPL',
);

my $stripped_out = 0;

sub translit_out {
  if(Irssi::settings_get_bool('translit') && !$stripped_out) {
    my $emitted_signal = Irssi::signal_get_emitted();
    my ($msg, $dummy1, $dummy2) = @_;

    $dummy1 =~ s/�/a/g;
    $dummy1 =~ s/�/b/g;
    $dummy1 =~ s/�/v/g;
    $dummy1 =~ s/�/g/g;
    $dummy1 =~ s/�/d/g;
    $dummy1 =~ s/�/e/g;
    $dummy1 =~ s/�/jo/g;
    $dummy1 =~ s/�/zh/g;
    $dummy1 =~ s/�/z/g;
    $dummy1 =~ s/�/i/g;
    $dummy1 =~ s/�/j/g;
    $dummy1 =~ s/�/k/g;
    $dummy1 =~ s/�/l/g;
    $dummy1 =~ s/�/m/g;
    $dummy1 =~ s/�/n/g;
    $dummy1 =~ s/�/o/g;
    $dummy1 =~ s/�/p/g;
    $dummy1 =~ s/�/r/g;
    $dummy1 =~ s/�/s/g;
    $dummy1 =~ s/�/t/g;
    $dummy1 =~ s/�/u/g;
    $dummy1 =~ s/�/f/g;
    $dummy1 =~ s/�/h/g;
    $dummy1 =~ s/�/c/g;
    $dummy1 =~ s/�/ch/g;
    $dummy1 =~ s/�/sh/g;
    $dummy1 =~ s/�/sch/g;
    $dummy1 =~ s/�/`/g;
    $dummy1 =~ s/�/y/g;
    $dummy1 =~ s/�/`/g;
    $dummy1 =~ s/�/e/g;
    $dummy1 =~ s/�/ju/g;
    $dummy1 =~ s/�/ja/g;

    $dummy1 =~ s/�/A/g;
    $dummy1 =~ s/�/B/g;
    $dummy1 =~ s/�/V/g;
    $dummy1 =~ s/�/G/g;
    $dummy1 =~ s/�/D/g;
    $dummy1 =~ s/�/E/g;
    $dummy1 =~ s/�/JO/g;
    $dummy1 =~ s/�/ZH/g;
    $dummy1 =~ s/�/Z/g;
    $dummy1 =~ s/�/I/g;
    $dummy1 =~ s/�/J/g;
    $dummy1 =~ s/�/K/g;
    $dummy1 =~ s/�/L/g;
    $dummy1 =~ s/�/M/g;
    $dummy1 =~ s/�/N/g;
    $dummy1 =~ s/�/O/g;
    $dummy1 =~ s/�/P/g;
    $dummy1 =~ s/�/R/g;
    $dummy1 =~ s/�/S/g;
    $dummy1 =~ s/�/T/g;
    $dummy1 =~ s/�/U/g;
    $dummy1 =~ s/�/F/g;
    $dummy1 =~ s/�/H/g;
    $dummy1 =~ s/�/C/g;
    $dummy1 =~ s/�/CH/g;
    $dummy1 =~ s/�/SH/g;
    $dummy1 =~ s/�/SCH/g;
    $dummy1 =~ s/�/`/g;
    $dummy1 =~ s/�/Y/g;
    $dummy1 =~ s/�/`/g;
    $dummy1 =~ s/�/E/g;
    $dummy1 =~ s/�/JU/g;
    $dummy1 =~ s/�/JA/g;

    $stripped_out=1;

    Irssi::signal_emit("$emitted_signal", $msg, $dummy1, $dummy2 );
    Irssi::signal_stop();
    $stripped_out=0;
  }
}

Irssi::settings_add_bool('lookandfeel', 'translit', 1);

#output filters:
#Irssi::signal_add_first('send command', 'translit_out');
Irssi::signal_add_first('message own_public', 'translit_out');
Irssi::signal_add_first('message own_private', 'translit_out');


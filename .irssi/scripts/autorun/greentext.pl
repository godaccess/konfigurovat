#!/usr/bin/env perl -w
use vars qw($VERSION %IRSSI);

$VERSION = "1";
%IRSSI = (
	authors     => "dcat,kori",
	name        => "greentext.pl",
	license     => "beerware"
);

sub greentext () {
	my ($text, $server, $witem) =@_;
	if ($text =~ /^>/) {
		$text = "\0033" . $text;
	}
	Irssi::signal_continue($text, $server, $witem);
	return 0;
}

Irssi::signal_add_first("send text", "greentext");
use strict;

use ExtUtils::MakeMaker qw(WriteMakefile prompt);

my %PREREQ_PM = (
    'Net::Google'   => undef,
    'Symbol'        => undef,
);

my %clean = (
    FILES => '$(DISTVNAME).tar$(SUFFIX) *.xsi .googlekey',
);

my $key = prompt("Enter your Google API key, or a filename containing it:");

WriteMakefile(
    NAME        => "Tie::Google",
    VERSION     => "0.01",
    PREREQ_PM   => \%PREREQ_PM,
    clean       => \%clean,
    macro       => { GOOGLE_KEY => $key },
);

package MY;
sub postamble {
    <<'P';
all :: write_googlekey

write_googlekey:
	if [ "x$(GOOGLE_KEY)" != "x" ]; then cat $(GOOGLE_KEY) > .googlekey; else touch .googlekey; fi
P
}

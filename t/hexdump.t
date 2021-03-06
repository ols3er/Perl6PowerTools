#!perl6

use v6;

use Test;

my $program = $*SPEC.catfile: <bin hexdump>;

my $null_fh = $*SPEC.devnull.IO.open;

subtest {
	ok $program.IO.e, "Program {$program} exists";
	my $proc = run $*EXECUTABLE, '-c', $program, :out, :err($null_fh);
	my $output = $proc.out.slurp-rest;
	is $output, "Syntax OK\n";
	try { # https://rt.perl.org/Ticket/Display.html?id=125757
		$proc.out.close;
		$proc.err.close
		};
	is $proc.exitcode, 0, 'compile check exit code';
	}, 'Boring setup things';

done-testing();

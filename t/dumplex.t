use Test::More;
my $have_padwalker = eval q(use PadWalker '1'; 1;);
my $have_tnw = eval q(use Test::NoWarnings; 1;);
if ($have_padwalker) {
    plan tests => 2;
} else {
    plan skip_all => 'DumpLex requires PadWalker => 1.0';
};

use Data::Dump::Streamer;

my $foo = "bar";
is DumpLex($foo)->Out, q($foo = 'bar';) . "\n",
    'lexical name instead of generic $VAR1';

SKIP: {
    skip 'requires Test::NoWarnings', 1 unless $have_tnw;
    diag q(provoke 'uninitialized' warning like bug 28053);
    diag DumpLex([[q(), undef]]);
};

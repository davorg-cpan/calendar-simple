# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
use Calendar::Simple;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

my @month = calendar(9, 2002);

ok(@month == 5);
ok(@{$month[0]} == 7);
ok($month[0][0] == 1);

@month = calendar(2, 2009);
ok(@month == 4);
ok($month[0][0] == 1);
ok($month[3][6] == 28);

@month = calendar(1, 2002);
ok(not defined $month[0][0]);
ok($month[0][2] == 1);
ok($month[4][4] == 31);
ok(not defined $month[4][6]);

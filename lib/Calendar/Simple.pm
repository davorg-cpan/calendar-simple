
package Calendar::Simple;

use strict;
use vars qw(@ISA @EXPORT $VERSION);

require Exporter;

@ISA = qw(Exporter);

@EXPORT = qw(calendar);
$VERSION = '0.01';

use Time::Local;
use Carp;

my @days = qw(31 xx 31 30 31 30 31 31 30 31 30 31);

sub calendar {
  my ($mon, $year) = @_;

  my @now = (localtime)[4, 5];

  $mon ||= ($now[0] + 1);
  $year ||= ($now[1] + 1900);

  croak "Year $year out of range" if $year < 1970;

  my $first = (localtime timelocal 0, 0, 0, 1, $mon -1, $year - 1900)[6];

  my @mon = (1 .. days($mon, $year));

  my @first_wk = (undef) x 7;
  @first_wk[$first .. 6] = splice @mon, 0, 6 - $first + 1;

  my @month = (\@first_wk);

  while (my @wk = splice @mon, 0, 7) {
    push @month, \@wk;
  }

  return wantarray ? @month : \@month;
}

sub days {
  my ($mon, $yr) = @_;

  return $days[$mon - 1] unless $mon == 2;
  return isleap($yr) ? 29 : 28;
}

sub isleap {
  return 1 unless $_[0] % 400;
  return   unless $_[0] % 100;
  return 1 unless $_[0] % 4;
  return;
}

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Calendar::Simple - Perl extension to create simple calendars

=head1 SYNOPSIS

  use Calendar::Simple;

  my @curr      = calendar;          # get current month
  my @this_sept = calendar(9);       # get 9th month of current year
  my @sept_2002 = calendat(9, 2002); # get 9th month of 2002

=head1 DESCRIPTION

A very simple module that exports one functions called C<calendar>.
This function returns a data structure representing the dates in a month.
The data structure returned is an array of array references. The first
level array represents the weeks in the month. The second level array
contains the actual days. Each week starts on a Sunday and the value in
the array is the date of that day. Any days at the beginning of the first
week or the end of the last week that are from the previous or next month
have the value C<undef>.

If the month or year parameters are omitted then the current month or
year are assumed.

A simple C<cal> replacement would therefore look like this:

  #!/usr/bin/perl -w

  use strict;
  use Calendar::Simple;

  my @months = qw(January February March April May June July August
                  September October November December);

  my $mon = shift || (localtime)[4] + 1;
  my $yr = shift || ((localtime)[5] + 1900);

  my @month = calendar($mon, $yr);

  print "\n$months[$mon -1] $yr\n\n";
  print "Su Mo Tu We Th Fr Sa\n";
  foreach (@month) {
    print map { $_ ? sprintf "%2d ", $_ : '   ' } @$_;
    print "\n";
  }


=head2 EXPORT

C<calendar>


=head1 AUTHOR

Dave Cross <dave@dave.org.uk>

=head1 SEE ALSO

L<perl>.

=cut

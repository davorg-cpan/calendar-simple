#
# DESCRIPTION
#  Calendar::Simple.pm is a Perl object that compares arrays.
#
# AUTHOR
#   Dave Cross   <dave@dave@dave.org.uk>
#
# COPYRIGHT
#   Copyright (C) 2002, Dave Cross.  All Rights Reserved.
#
#   This script is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
# $Id$
#
# $Log$
# Revision 1.3  2002/07/12 18:25:13  dave
# Added CVS tags
#


package Calendar::Simple;

use strict;
use vars qw(@ISA @EXPORT $VERSION);

require Exporter;

@ISA = qw(Exporter);

@EXPORT = qw(calendar);
$VERSION = sprintf "%d.%02d", '$Revision$ ' =~ /(\d+)\.(\d+)/;

use Time::Local;
use Carp;

my @days = qw(31 xx 31 30 31 30 31 31 30 31 30 31);

sub calendar {
  my ($mon, $year, $start_day) = @_;

  my @now = (localtime)[4, 5];

  $mon ||= ($now[0] + 1);
  $year ||= ($now[1] + 1900);

  croak "Year $year out of range" if $year < 1970;
  croak "Month $mon out of range" if ($mon  < 1 || $mon > 12);
  croak "Start day $start_day out of range" 
    if ($start_day < 0 || $start_day > 6);

  my $first 
    = (localtime timelocal 0, 0, 0, 1, $mon -1, $year - 1900)[6];
  $first -= $start_day;
  $first = 7+$first if ($first < 0);

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
  my @sept_2002 = calendar(9, 2002); # get 9th month of 2002
  my @monday    = calendar(9, 2002, 1); # get 9th month of 2002,
                                          weeks start on Monday

=head1 DESCRIPTION

A very simple module that exports one functions called C<calendar>. This
function returns a data structure representing the dates in a month. The
data structure returned is an array of array references. The first level
array represents the weeks in the month. The second level array contains
the actual days. By default, each week starts on a Sunday and the value
in the array is the date of that day. Any days at the beginning of the
first week or the end of the last week that are from the previous or
next month have the value C<undef>.

If the month or year parameters are omitted then the current month or
year are assumed.

A third, optional parameter, start_day, allows you to set the day each
week starts with, with the same values as localtime sets for wday
(namely, 0 for Sunday, 1 for Monday and so on).

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

=head2 EXPORT\

C<calendar>

=head1 AUTHOR

Dave Cross <dave@dave.org.uk>

With thanks to Paul Mison <paulm@husk.org> for the start day patch.

=head1 SEE ALSO

L<perl>, L<perldoc -f localtime>

=cut

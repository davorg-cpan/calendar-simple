use Module::Build;

my $build = Module::Build->new(
  license            => 'perl',
  dist_author        => 'Dave Cross <dave@mag-sol.com>',
  module_name        => 'Calendar::Simple',
  requires           => {
    perl                  => '5.10.0',
    Carp                  => 0,
    'Time::Local'         => 0,
    Config                => 0,
  },
  recommends         => {
    DateTime              => 0,
  },
  build_requires     => {
    'Test::More'          => 0,
  },
  build_recommends   => {
    'Test::Pod'           => 0,
    'Test::Pod::Coverage' => 0,
  },
  create_makefile_pl => 'traditional',
  script_files       => [ 'bin/pcal' ],
  meta_merge => {
    'meta-spec' => { version => 2 },
    resources => {
      repository => {
        type => 'git',
        url => 'https://github.com/davorg-cpan/calendar-simple.git',
        web => 'https://github.com/davorg-cpan/calendar-simple',
      },
      bugtracker => {
        web => 'https://github.com/davorg-cpan/calendar-simple/issues',
      },
    },
  },
);

$build->create_build_script;

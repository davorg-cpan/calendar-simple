use Module::Build;

my $build = Module::Build->new(
                               dist_author => 'Dave Cross <dave@dave.org.uk',
                               module_name => 'Calendar::Simple',
                               license     => 'perl',
                               requires    => {
                                               Test::More => 0,
                                              },
                               create_makefile_pl => 'traditional',
                               sign        => 1,
                              );

$build->create_build_script;

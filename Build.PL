use Module::Build;

my $build = Module::Build->new(module_name => 'Calendar::Simple',
                               license     => 'perl',
                               requires    => {
                                               Test::More => 0,
                                              },
                               create_makefile_pl => 'passthrough');

$build->create_build_script;

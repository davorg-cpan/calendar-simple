use Module::Build;

my $build = Module::Build->new(
	dist_version       => '1.18',
	dist_author        => 'Dave Cross <dave@mag-sol.com>',
        module_name        => 'Calendar::Simple',
	requires           => {
		Carp                => 0,
		Time::Local         => 0,
	},
	recommends         => {
		DateTime            => 0,
	},
        build_requires     => {
        	Test::More          => 0,
        },
	build_recommends   => {
		Test::Pod           => 0,
		Test::Pod::Coverage => 0,
	},
        create_makefile_pl => 'traditional',
        script_files       => [ 'bin/pcal' ],
        sign               => 1,
);

$build->create_build_script;

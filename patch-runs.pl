#!/usr/bin/perl -w

use strict;
use warnings;

use Mojo::File;
use Encode qw(decode encode);

my $modpaths = {
	bonsaitrees3 => 'BonsaiTrees',
	libnonymous => 'libnonymous',
	slimeclicker => 'SlimeClicker',
	#riddlechests => 'RiddleChests',
};


my @entries;
foreach my $modId (sort keys($modpaths->%*)) {
	my $modPath = $modpaths->{$modId};
	push @entries, $modId . '%%$PROJECT_DIR$/../MultiWorkspace\\' . $modPath . '\out\production\resources';
	push @entries, $modId . '%%$PROJECT_DIR$/../MultiWorkspace\\' . $modPath . '\out\production\classes';
}

my $mod_classes = sprintf('<env name="MOD_CLASSES" value="%s"/>', join(';', @entries));

my $path = Mojo::File->new('./.idea/runConfigurations/');
foreach my $file ($path->list->each) {
	printf "Found file: %s\n", $file;
	my $content = decode('UTF-8', $file->slurp);

	my $overwrite = '';
	foreach my $line (split(/\r\n/, $content)) {
		if($line =~ m/^\s*<env name="MOD_CLASSES"/) {
			$overwrite .= "        " . $mod_classes . "\r\n";
		} elsif($line =~ m/^\s*<module name/) {
			$overwrite .= "    <module name=\"1.18_davenonymous.workspace.main\" />\r\n";
		} else {
			$overwrite .= $line . "\r\n";
			if($line =~ m/\s*<configuration/) {
				$overwrite .= "    <option name=\"ALTERNATIVE_JRE_PATH\" value=\"17\" />\r\n";
				$overwrite .= "    <option name=\"ALTERNATIVE_JRE_PATH_ENABLED\" value=\"true\" />\r\n";
			}
		}
	}

	$file->spurt(encode('UTF-8', $overwrite));
}


# '<env name="MOD_CLASSES" value="bonsaitrees3%%$PROJECT_DIR$/../MultiWorkspace\workspace\out\main\resources;bonsaitrees3%%$PROJECT_DIR$/../MultiWorkspace\workspace\out\main\classes;libnonymous%%$PROJECT_DIR$/../MultiWorkspace\workspace\out\main\resources;libnonymous%%$PROJECT_DIR$/../MultiWorkspace\workspace\out\main\classes;slimeclicker%%$PROJECT_DIR$/../MultiWorkspace\workspace\out\main\resources;slimeclicker%%$PROJECT_DIR$/../MultiWorkspace\workspace\out\main\classes" />'

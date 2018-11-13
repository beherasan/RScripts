#!/usr/bin/perl

open(IN,"DBP_TMT_Cerebellum_Proteins.txt") or die "Could not open the file:$!\n";

while(<IN>)
{
	chomp;
	$count_replicate=$count_channel=0;
	@line=(split /\t/);
	for($i=1;$i<scalar(@line);$i++)
	{
		$v=$line[$i];
		unless($v == 0)
		{
			$count_replicate++;
		}
		if($i%3 == 0)
		{
			if($count_replicate == 3)
			{
				$count_channel++;
			}
			$count_replicate=0;
		}
	}
	if($count_channel == 9)
	{
		print "$_\n";
	}
}
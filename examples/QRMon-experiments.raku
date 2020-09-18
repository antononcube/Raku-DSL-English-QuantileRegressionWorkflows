use lib './lib';
use lib '.';
use DSL::English::QuantileRegressionWorkflows;


my $commands = '
DSL TARGET WL-QRMon;
create from tsData; delete missing;
echo data summary;
rescale both axes;
compute quantile regression with 20 knots and probabilities from 0.1 to 0.9 with step 0.1;
show date list plot;
plot absolute errors;
compute outliers;
echo pipeline value
';


say "\n=======\n";

say to_QRMon_Python( $commands );

say "\n=======\n";

say to_QRMon_R( $commands );

say "\n=======\n";

say to_QRMon_WL( $commands );

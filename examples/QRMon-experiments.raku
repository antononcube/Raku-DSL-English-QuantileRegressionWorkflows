use lib './lib';
use lib '.';
use DSL::English::QuantileRegressionWorkflows;
use DSL::English::QuantileRegressionWorkflows::Grammar;


# Shortcuts
#-----------------------------------------------------------
my $pCOMMAND = DSL::English::QuantileRegressionWorkflows::Grammar;

sub qr-parse(Str:D $command, Str:D :$rule = 'TOP') {
    $pCOMMAND.parse($command, :$rule);
}

sub qr-interpret(Str:D $command,
                 Str:D:$rule = 'TOP',
                 :$actions = DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon.new) {
    $pCOMMAND.parse($command, :$rule, :$actions).made;
}

#----------------------------------------------------------


my @commands = ('
include setup code;
create from dfTemperatureData;
delete missing;
echo data summary;
rescale both axes;
compute quantile regression with 20 knots and probabilities from 0.1 to 0.9 with step 0.1;
show date list plot;
plot absolute errors plots;
compute outliers;
echo pipeline context;
assign pipeline object to qrObj34;
';);

#my @targets = <Python-QRMon R-QRMon WL-QRMon Bulgarian>;
my @targets = <Bulgarian English>;

for @commands -> $c {
    say "\n", '=' x 20;
    say $c.trim;
    for @targets -> $t {
        say '-' x 20;
        say $t.trim;
        say '-' x 20;
        say ToQuantileRegressionWorkflowCode($c, $t, format => 'hash');
    }
}

#say qr-parse( @commands[0], rule => 'workflow-commands-list');

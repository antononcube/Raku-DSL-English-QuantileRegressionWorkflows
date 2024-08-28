
use DSL::English::QuantileRegressionWorkflows;
use DSL::English::QuantileRegressionWorkflows::Grammar;


# Shortcuts
#-----------------------------------------------------------
my $pCOMMAND = DSL::English::QuantileRegressionWorkflows::Grammar;

sub qr-subparse(Str:D $command, Str:D :$rule = 'TOP') {
    $pCOMMAND.subparse($command, :$rule);
}

sub qr-parse(Str:D $command, Str:D :$rule = 'TOP') {
    $pCOMMAND.parse($command, :$rule);
}

sub qr-interpret(Str:D $command,
                 Str:D:$rule = 'TOP',
                 :$actions = DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon.new) {
    $pCOMMAND.parse($command, :$rule, :$actions).made;
}

#----------------------------------------------------------

#say qr-subparse('show absolute errors plots');
#say '-' x 120;
#say qr-subparse('show plots of absolute errors');

my @commands = ('
include setup code;
create from dfTemperatureData;
delete missing;
echo data summary;
rescale both axes;
compute quantile regression with 20 knots and probabilities from 0.1 to 0.9 with step 0.1;
show date list plot;
show absolute errors plots;
plot relative errors plots;
show plots of the absolute errors;
compute and show outliers;
echo pipeline context;
assign pipeline object to qrObj34;
');


my @targets = <Python-QRMon R-QRMon WL-QRMon>;
#my @targets = <Bulgarian English Russian>;

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

# Parallel execution profiling
#`[
my $degree = 2;
my $batch = Whatever;
my $n = 1000;
my $tstart = now;
for ^$n {
    ToQuantileRegressionWorkflowCode(@commands.head, "WL::QRMon", format => 'hash', :$degree, :$batch);
}
my $tend = now;
say "Total time: {$tend - $tstart} for degree => $degree, batch => {$batch.gist}.";
say "Per call  : {($tend - $tstart) / $n}";

say ToQuantileRegressionWorkflowCode(@commands.head, "WL::QRMon", format => 'hash', :$degree, :$batch);
]
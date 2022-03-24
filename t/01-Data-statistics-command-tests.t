
use DSL::English::QuantileRegressionWorkflows::Grammar;

use Test;
plan 7;

# Shortcut
my $pQRMONCOMMAND = DSL::English::QuantileRegressionWorkflows::Grammar;

#-----------------------------------------------------------
# Data statistics
#-----------------------------------------------------------

ok $pQRMONCOMMAND.parse('summarize data'),
        'summarize data';

ok $pQRMONCOMMAND.parse('summarize the data'),
        'summarize the data';

ok $pQRMONCOMMAND.parse('show data summary'),
        'show data summary';

ok $pQRMONCOMMAND.parse('cross tabulate'),
        'cross tabulate';

ok $pQRMONCOMMAND.parse('cross tabulate the data'),
        'cross tabulate the data';

ok $pQRMONCOMMAND.parse('cross tabulate time variable vs dependent variable'),
        'cross tabulate time variable vs dependent variable';

ok $pQRMONCOMMAND.parse('cross tabulate the time variable vs the dependent'),
        'cross tabulate the time variable vs the dependent';

done-testing;
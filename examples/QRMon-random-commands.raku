use v6.d;

use DSL::English::QuantileRegressionWorkflows;
use DSL::English::QuantileRegressionWorkflows::Grammar;

use Grammar::TokenProcessing;
use Data::Reshapers;

my $focusGrammar = DSL::English::QuantileRegressionWorkflows::Grammar;
my %focusRules = $focusGrammar.^method_table;

my @commandRules = %focusRules.keys.grep({ $_ ~~ / .* '-command' $ / }).grep({ $_ !~~ / ^ [ dsl | user | setup | workflow ] '-' .* / });

my @tblRes;
for @commandRules.sort -> $cr {
        my @randSentences = (^10).map({ generate-random-sentence(
                '<' ~ $cr ~ '>',
                %focusRules,
                max-iterations => 40,
                random-token-generators => Whatever,
                sep => ' ') }).sort.unique;
        @tblRes = @tblRes.append( (@randSentences Z ^@randSentences.elems ).map({ %(Rule => $cr, Command => $_[0], Index => $_[1]) }) );
}

my %res = group-by(@tblRes, <Rule>);

%res.sort(*.key).map({ say to-pretty-table($_.value, align=>'l', field-names => <Rule Index Command>) });

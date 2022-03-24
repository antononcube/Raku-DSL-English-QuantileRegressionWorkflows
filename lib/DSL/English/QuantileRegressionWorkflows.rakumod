=begin pod

=head1 DSL::English::QuantileRegressionWorkflows

C<DSL::English::QuantileRegressionWorkflows> package has grammar classes and action classes for the parsing and
interpretation of English natural speech commands that specify Quantile Regression (QR) workflows.

=head1 Synopsis

    use DSL::English::QuantileRegressionWorkflows;
    my $gcode = ToQuantileRegressionWorkflowCode("compute quantile regression with 0.1 amd 0.9; show outliers");
    my $rcode = to_QRMon_R("compute quantile regression with 0.1 amd 0.9; show outliers");

=end pod

unit module DSL::English::QuantileRegressionWorkflows;

use DSL::Shared::Utilities::CommandProcessing;

use DSL::English::QuantileRegressionWorkflows::Grammar;
use DSL::English::QuantileRegressionWorkflows::Actions::Bulgarian::Standard;
use DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon;
use DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon;
use DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon;

my %targetToAction{Str} =
    "Bulgarian"        => DSL::English::QuantileRegressionWorkflows::Actions::Bulgarian::Standard,
    "Python"           => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "Python-QRMon"     => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "Python::QRMon"    => DSL::English::QuantileRegressionWorkflows::Actions::Python::QRMon,
    "R"                => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "R-QRMon"          => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "R::QRMon"         => DSL::English::QuantileRegressionWorkflows::Actions::R::QRMon,
    "Mathematica"      => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL"               => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL-QRMon"         => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon,
    "WL::QRMon"        => DSL::English::QuantileRegressionWorkflows::Actions::WL::QRMon;

my Str %targetToSeparator{Str} =
    "Bulgarian"        => "\n",
    "R"                => " %>%\n",
    "R-QRMon"          => " %>%\n",
    "R::QRMon"         => " %>%\n",
    "Mathematica"      => " \\[DoubleLongRightArrow]\n",
    "Python"           => "\n",
    "Python-QRMon"     => "\n",
    "Python::QRMon"    => "\n",
    "WL"               => " \\[DoubleLongRightArrow]\n",
    "WL-QRMon"         => " \\[DoubleLongRightArrow]\n",
    "WL::QRMon"        => " \\[DoubleLongRightArrow]\n";


#-----------------------------------------------------------
proto ToQuantileRegressionWorkflowCode(Str $command, Str $target = 'R-QRMon', | ) is export {*}

multi ToQuantileRegressionWorkflowCode( Str $command, Str $target = 'R-QRMon', *%args ) {

    DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode( $command,
                                                               grammar => DSL::English::QuantileRegressionWorkflows::Grammar,
                                                               :%targetToAction,
                                                               :%targetToSeparator,
                                                               :$target,
                                                               |%args )

}

#-----------------------------------------------------------
proto to_QRMon_Python($) is export {*}

multi to_QRMon_Python ( Str $command ) {
    return ToQuantileRegressionWorkflowCode( $command, 'Python-QRMon' );
}

#-----------------------------------------------------------
proto to_QRMon_R($) is export {*}

multi to_QRMon_R ( Str $command ) {
    return ToQuantileRegressionWorkflowCode( $command, 'R-QRMon' );
}

#-----------------------------------------------------------
proto to_QRMon_WL($) is export {*}

multi to_QRMon_WL ( Str $command ) {
    return ToQuantileRegressionWorkflowCode( $command, 'WL-QRMon' );
}

#!/usr/bin/env perl6
use DSL::English::QuantileRegressionWorkflows;

sub MAIN(Str $commands) {
    put ToQuantileRegressionWorkflowCode($commands);
}


use v6;
use Test;
use lib 'lib';
use DSL::English::QuantileRegressionWorkflows;

plan 15;

#-----------------------------------------------------------
# Data transformation
#-----------------------------------------------------------

## 1
ok to_QRMon_R('rescale x axis'),
        'rescale x axis';

## 2
ok to_QRMon_R('rescale regressor axis'),
        'rescale regressor axis';

## 3
ok to_QRMon_R('rescale y axis'),
        'rescale y axis';
## 4
ok to_QRMon_R('rescale value axis'),
        'rescale value axis';
## 5
ok to_QRMon_R('rescale both axes'),
        'rescale both axes';

## 6
ok to_QRMon_R('resample'),
        'resample';

## 7
ok to_QRMon_R('resample the time series with step 0.3'),
        'resample the time series with step 0.3';

## 8
ok to_QRMon_R('resample with linear interpolation'),
        'resample with linear interpolation';

## 9
ok to_QRMon_R('moving average using 5'),
        'moving average using 5';

## 10
ok to_QRMon_R('moving median with 5 elements'),
        'moving average using 5';

## 11
ok to_QRMon_R('moving average with weights 1, 2, 5'),
        'moving average with weights 1, 2, 5';

## 12
ok to_QRMon_R('moving map Mean with 5 elements'),
        'moving map Mean with 5 elements';

## 13
ok to_QRMon_R('resample with hold value from left'),
        'resample with hold value from left';

## 14
ok to_QRMon_R('resample with HoldValueFromLeft'),
        'resample with HoldValueFromLeft';

## 15
ok to_QRMon_R('resample the time series'),
        'resample the time series';

# ok to_QRMon_R('moving average using two days'),
# 'moving average using two days';

done-testing;
<?php return array (
  'DHL' => '\\d{10}',
  'UPS' => 'H\\d{10}',
  'USPS' => '(?:LK|CJ|EC)\\d{9}(?:US|CN)',
  'FEDEX' => '\\d{12}',
  'Yanwen' => 'YW\\d{9}[A-Z]{2}',
  'TNT' => 'GD\\d{9}WW',
  '4PX' => 'RF\\d{9}SG',
  'HKMail' => 'RC\\d{9}HK',
); ?>

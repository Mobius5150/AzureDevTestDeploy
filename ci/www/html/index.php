<html>
  <head>
    <title>Test Results</title>
  </head>
  <body>
    <h1>PHP Web Application Test Results</h1>
    <p>Test Host: <?php echo gethostname() ?>
    <?php
      if (file_exists('load_test_in_progress')) :
        ?><p>The load test is in progress...</p><script type="text/javascript">setTimeout(function () {window.location.reload(true);}, 2000);</script><?
      else :
        $entryCount = 0;
        $limit = 200;
        $entriesOverLimit = 0;
        $maxEntriesOverLimitPercent = 0.01;

        if (false !== ($file = fopen('benchmark.tsv', 'r'))) {
          while (false !== ($line = fgetcsv($file, 1000, "\t"))) {
            if (++$entryCount === 0) {
              continue;
            }

            if (intval($line[4]) >= $limit) {
              ++$entriesOverLimit;
            }
          }

          fclose($file);
        }

        $failedPercent = $entriesOverLimit/$entryCount;
        $resultStr = "$entriesOverLimit/$entryCount (less than 1%) of requests took longer than " . number_format($limit) . 'ms. The load test was a success.';
        $style = '';
        if (($success = $failedPercent > $maxEntriesOverLimitPercent)) {
          $failedPercentStr = number_format($failedPercent * 100, 1);
          $resultStr = "$entriesOverLimit/$entryCount requests ({$failedPercentStr}%) took more than " . number_format($limit) . 'ms. The load test was a failure.';
          $style = 'color: crimson;';
        }
    ?>
      <p><span style="<?php echo $style; ?>"><?php echo $resultStr; ?></span></p>
      <img src="request_plot.jpg" alt="Benchmark Result Graph" />
    <? endif; ?>
  </body>
</html>

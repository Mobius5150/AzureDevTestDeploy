<html>
  <head>
    <title>Hello World!</title>
  </head>
  <body>
    <img src="image/Container-255x115.png" alt="Azure Container Service Logo" style="float:right"/>
    <h1>Hello from the PHP Web application</h1>
    <p>Host: <?php echo gethostname() ?>
    <?php

       function fibonacci($n) {
         if ($n === 0) return 0;
	 if ($n === 1) return 1;

	 return fibonacci($n - 1) + fibonacci($n - 2);
       }

       fibonacci(23);

       $service_url = 'http://rest:8080/JerseyHelloWorld/rest/helloworld';
       $curl = curl_init($service_url);
       curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
       $curl_response = curl_exec($curl);
       if ($curl_response === false) {
         $info = curl_getinfo($curl);
         curl_close($curl);
         die('error occured during curl exec. Additioanl info: ' . var_export($info));
       }

       curl_close($curl);
    ?>
    <h1>Rest API Response</h1>
    <?php echo $curl_response ?>
  </body>
</html>

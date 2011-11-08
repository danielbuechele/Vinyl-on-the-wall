import processing.serial.*;

int mode;
String message;
Serial port;

  void setup(){
    
    // init connection to arduino
    port = new Serial(this, Serial.list()[0], 57600);    
    
  }


  void draw(){
    
  }




  // serial event
  void serialEvent(Serial p){
    
    
    // get message till line break (ASCII > 13)
    message = p.readStringUntil(13);
    // just if there is data
    if (message != null) {
      // try catch function because of possible garbage in received data
      String msg = trim(message);
      mode = Integer.parseInt(msg);
      println(mode);
      
        
        //trim(message);
        //mode = Integer.parseInt(message);
        
  
        

         //
         // VOLUME
         //
         
         if (mode >= 0 && mode <= 100){
          shellExec("osascript -e \"tell application \\\"iTunes\\\" to set the sound volume to "+mode+"\"");
         }
        
        
         //
        // PLAY / PAUSE
        //
        else if (mode == 200){
          shellExec("osascript -e \"tell application \\\"iTunes\\\" to playpause\"");
        }
        
        //
        //  NEXT TRACK
        //
        else if (mode == 300){
          shellExec("osascript -e \"tell application \\\"iTunes\\\" to next track\"");
        }
        
        //
        // PREVIOUS TRACK
        //
        if (mode == 400){
          shellExec("osascript -e \"tell application \\\"iTunes\\\" to previous track\"");
        }
         
        
        
      
    }

  
  delay(100);
  
  
  }






Vector shellExec ( String command )
{
 return shellExec ( new String[]{ "/bin/bash", "-c", command } );
}

Vector shellExec ( String[] command )
{
 Vector lines = new Vector();
 try {
   Process process = Runtime.getRuntime().exec ( command );

   BufferedReader inBufferedReader  = new BufferedReader( new InputStreamReader ( process.getInputStream() ) );
   BufferedReader errBufferedReader = new BufferedReader( new InputStreamReader ( process.getErrorStream() ) );

   String line, eline;
   while ( (line  = inBufferedReader.readLine() ) != null && !errBufferedReader.ready() )
   {
    lines.add(line);
   }
   if ( errBufferedReader.ready() ) {
    while ( (eline  = errBufferedReader.readLine() ) != null )
    {
      //println( eline );
    }
    return null;
   }
   int exitVal = process.waitFor();

   inBufferedReader.close();  process.getInputStream().close();
   errBufferedReader.close(); process.getErrorStream().close();
 }
 catch (Exception e)
 {
 //  e.printStackTrace();
   return null;
 }

 return lines;
}





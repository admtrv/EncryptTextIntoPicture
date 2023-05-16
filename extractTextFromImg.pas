uses School;

{$reference 'System.Drawing.dll'}
{Enter the name of the image file in the Create( ) window}
var
  bitmap := System.Drawing.Bitmap.Create('imgWithEncryptedText.bmp');

begin
  var (width, height) := (bitmap.Width, bitmap.Height);
  var text: text; Assign(text, 'extractedText.txt'); Rewrite(text);
  
  
  for var j := 0 to height - 1 do
    for var i := 0 to width - 1 do 
    begin
      var colour := bitmap.GetPixel(i, j);
      var (red, green, blue) := (tobase(colour.R.tostring,2), tobase(colour.g.ToString,2), tobase(colour.b.ToString,2));
      
      red := (8-red.Length)*'0' + red;
      green := (8-green.Length)*'0' + green;
      blue := (8-blue.Length)*'0' + blue;
      
      var letter := chr(dec(red[6:9] + green[7:9] + blue[6:9],2));
      
      if letter <> '~' then 
        write(text, letter)
      else
        begin
        close(text);
        exit;
        end;
    end;
end.